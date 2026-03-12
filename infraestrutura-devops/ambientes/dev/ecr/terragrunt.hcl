include { path = find_in_parent_folders() }

terraform { source = "../../../modules/ecr" }

inputs = {
  name = "app-dev-backend"
  tags = { Project = "devops-poc", Env = "dev", ManagedBy = "terragrunt" }
}