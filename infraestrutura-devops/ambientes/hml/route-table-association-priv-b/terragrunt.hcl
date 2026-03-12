# ambientes/hml/route-table-association-priv-b/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "subnet_priv_b" {
  config_path = "../subnet-priv-b"
  mock_outputs = { subnet_id = "subnet-priv-b" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}
dependency "route_table_priv" {
  config_path = "../route-table-priv"
  mock_outputs = { route_table_id = "rtb-priv" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/route-table-association-priv" }

inputs = {
  subnet_id      = dependency.subnet_priv_b.outputs.subnet_id
  route_table_id = dependency.route_table_priv.outputs.route_table_id
}