resource "aws_ecr_repository" "python-api" {
  name                 = "python-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}