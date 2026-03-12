terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = ">= 5.0" } }
}

resource "aws_kms_key" "ecr" {
  description         = "ECR images encryption (DEV)"
  enable_key_rotation = true
}

resource "aws_ecr_repository" "repo" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
    kms_key        = aws_kms_key.ecr.arn
  }
  image_scanning_configuration { scan_on_push = true }
  force_delete = true
  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.repo.name
  policy     = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep 30 most recent tags",
        selection    = { tagStatus = "tagged", tagPrefixList = ["dev"], countType = "imageCountMoreThan", countNumber = 30 },
        action       = { type = "expire" }
      },
      {
        rulePriority = 2,
        description  = "Expire untagged older than 14d",
        selection    = { tagStatus = "untagged", countType = "sinceImagePushed", countUnit = "days", countNumber = 14 },
        action       = { type = "expire" }
      }
    ]
  })
}

output "repository_url" { value = aws_ecr_repository.repo.repository_url }