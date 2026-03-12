locals {
  aws_region = "us-east-1"
  tags = {
    Project   = "kubeadriano"
    ManagedBy = "terragrunt"
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "kubeadriano-${get_aws_account_id()}-${local.aws_region}-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "kubeadriano-${get_aws_account_id()}-tf-locks"
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

terraform {
  extra_arguments "no_input" {
    commands  = ["init", "plan", "apply", "destroy"]
    arguments = ["-input=false", "-no-color"]
  }
}

inputs = {
  common_tags = local.tags
}