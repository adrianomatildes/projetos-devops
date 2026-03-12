# ambientes/prd/internet-gateway/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "nat" {
  config_path = "../nat-gateway"
  mock_outputs = { nat_gateway_id = "nat-dummy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = { vpc_id = "vpc-destroy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/internet-gateway" }

inputs = {
  name   = "prd"
  vpc_id = dependency.vpc.outputs.vpc_id
}
