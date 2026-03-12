# ambientes/prd/eks/terragrunt.hcl

include { path = find_in_parent_folders() }

dependency "subnet_priv_a" {
  config_path = "../subnet-priv"
  mock_outputs = { subnet_id = "subnet-a" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}
dependency "subnet_priv_b" {
  config_path = "../subnet-priv-b"
  mock_outputs = { subnet_id = "subnet-b" }
  mock_outputs_allowed_terraform_commands = ["destroy"]
}

terraform { source = "../../../modules/eks" }

inputs = {
  name            = "prd"
  cluster_name    = "eks-prd"
  node_group_name = "nodegroup-prd"

  subnet_ids = [
    dependency.subnet_priv_a.outputs.subnet_id,
    dependency.subnet_priv_b.outputs.subnet_id
  ]
  node_subnet_ids = [
    dependency.subnet_priv_a.outputs.subnet_id,
    dependency.subnet_priv_b.outputs.subnet_id
  ]
  # Parâmetros específicos de PRD
  eks_version  = "1.30"
  desired_size = 1     # número desejado de nós 3
  min_size     = 1     # mínimo de nós 2
  max_size     = 5     # máximo de nós 5
  instance_type = "t3.medium"  # ou m5.large, c5.xlarge, etc
}