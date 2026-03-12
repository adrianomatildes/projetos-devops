# ambientes/prd/vpc/terragrunt.hcl
include { 
  path = find_in_parent_folders() 
}

terraform { source = "../../../modules/vpc" }

inputs = {
  name       = "prd"
  cidr_block = "10.2.0.0/16"
}