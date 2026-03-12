# ambientes/dev/subnet-priv/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = { vpc_id = "vpc-dummy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/subnet-priv" }

inputs = {
  name              = "dev"
  vpc_id            = dependency.vpc.outputs.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}