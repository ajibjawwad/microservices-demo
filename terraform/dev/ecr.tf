module "ecr-sock-shop" {
    source = "terraform-aws-modules/ecr/aws"
    version = "2.4.0"
    for_each = toset(var.ecr_name)

    repository_name                 = "${each.value}"
    repository_image_tag_mutability = "MUTABLE"
    repository_image_scan_on_push   = false
    repository_lifecycle_policy     = jsonencode({
        rules = [
            {
                rulePriority    = 1,
                description     = "Remove untagged images",
                selection       = {
                    tagStatus   = "untagged"
                    countType   = "sinceImagePushed"
                    countUnit   = "days"
                    countNumber = 7
                },
                action = {
                    type = "expire"
                }
            }
        ]
    })

    tags = {
        Environment = "${local.environment}"
    }
}