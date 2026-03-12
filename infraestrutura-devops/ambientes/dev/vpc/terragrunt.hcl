# ambientes/dev/vpc/terragrunt.hcl
include { 
  path = find_in_parent_folders() 
}

terraform { source = "../../../modules/vpc" }

inputs = {
  name       = "dev"
  cidr_block = "10.0.0.0/16"
}