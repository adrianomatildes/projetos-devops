# ambientes/prd/eip/terragrunt.hcl

include { 
  path = find_in_parent_folders() 
}

terraform { source = "../../../modules/eip" }

inputs = {
  name = "prd"
}