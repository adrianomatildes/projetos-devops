# ambientes/dev/eks/terragrunt.hcl

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
  name            = "dev"
  cluster_name    = "eks-dev"
  node_group_name = "nodegroup-dev"

  subnet_ids = [
    dependency.subnet_priv_a.outputs.subnet_id,
    dependency.subnet_priv_b.outputs.subnet_id
  ]
  node_subnet_ids = [
    dependency.subnet_priv_a.outputs.subnet_id,
    dependency.subnet_priv_b.outputs.subnet_id
  ]
  # Parâmetros customizados
  eks_version   = "1.30"        # versão específica
  desired_size  = 1             # número desejado de nós 2
  min_size      = 1             # mínimo de nós 1
  max_size      = 3             # máximo de nós 3
  instance_type = "t3.small"    # tipo de instância EC2 do node
}