# ambientes/hml/nat-gateway/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "subnet_pub" {
  config_path = "../subnet-pub"
  mock_outputs = { subnet_id = "subnet-pub" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}
dependency "eip" {
  config_path = "../eip"
  mock_outputs = { allocation_id = "eipalloc-dummy" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/nat-gateway" }

inputs = {
  name          = "hml"
  subnet_id     = dependency.subnet_pub.outputs.subnet_id
  allocation_id = dependency.eip.outputs.allocation_id
}