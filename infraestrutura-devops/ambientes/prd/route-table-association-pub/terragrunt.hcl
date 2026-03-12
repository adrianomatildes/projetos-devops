# ambientes/prd/route-table-association-pub/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "subnet_pub" {
  config_path = "../subnet-pub"
  mock_outputs = { subnet_id = "subnet-pub" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}
dependency "route_table_pub" {
  config_path = "../route-table"
  mock_outputs = { route_table_id = "rtb-pub" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/route-table-association-pub" }

inputs = {
  subnet_id      = dependency.subnet_pub.outputs.subnet_id
  route_table_id = dependency.route_table_pub.outputs.route_table_id
}