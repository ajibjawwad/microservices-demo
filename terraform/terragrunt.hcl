remote_state {
  backend = "s3"
  generate = {
    path = "main_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config       = {
    bucket          = "terrafrom-tfstate"
    key             = "${path_relative_to_include()}/terrafrom.tfstate"
    region          = "us-east-1"
    encrypt         = true
    dynamodb_table  = "terrafrom-tfstate"
  }
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", false))
}

locals {
  aws_region = "us-east-1"
}

generate "provider" {
  path      = "main_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = ">= 2.50, < 5.94.1"
      }
    }
  }

  EOF
}