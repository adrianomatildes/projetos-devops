# ambientes/hml/vpc/terragrunt.hcl
include { 
  path = find_in_parent_folders() 
}

terraform { source = "../../../modules/vpc" }

inputs = {
  name       = "hml"
  cidr_block = "10.1.0.0/16"
}