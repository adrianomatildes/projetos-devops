# ambientes/hml/route-table-priv/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = { vpc_id = "vpc-destroy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}
dependency "nat" {
  config_path = "../nat-gateway"
  mock_outputs = { nat_gateway_id = "nat-dummy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/route-table-priv" }

inputs = {
  name           = "hml"
  vpc_id         = dependency.vpc.outputs.vpc_id
  nat_gateway_id = dependency.nat.outputs.nat_gateway_id
  cidr_block     = "0.0.0.0/0"
}