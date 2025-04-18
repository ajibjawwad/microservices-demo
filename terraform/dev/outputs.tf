output "vpc_id" {
  description = "Get VPC ID"
  value = module.vpc_eks_dev.vpc_id
}

output "private_subnet_list" {
  description = "List of Private Subnet"
  value = module.vpc_eks_dev.private_subnets
}

output "public_subnet_list" {
  description = "List of Public Subnet"
  value = module.vpc_eks_dev.public_subnets
}

output "database_subnet_list" {
  description = "List of Database Subnet"
  value = module.vpc_eks_dev.database_subnets
}

output "oidc_provider_arn" {
  value = module.eks_cluster.oidc_provider_arn

}

output "oidc_provider" {
  value = module.eks_cluster.oidc_provider
}