# ambientes/hml/route-table/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = { vpc_id = "vpc-destroy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

dependency "igw" {
  config_path = "../internet-gateway"
  mock_outputs = { igw_id = "igw-000000" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/route-table" }

inputs = {
  name       = "hml"
  vpc_id     = dependency.vpc.outputs.vpc_id
  gateway_id = dependency.igw.outputs.igw_id
  cidr_block = "0.0.0.0/0"
}