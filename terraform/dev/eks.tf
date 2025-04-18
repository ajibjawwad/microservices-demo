# module "eks_cluster" {
#     source = "terraform-aws-modules/eks/aws"
#     version = "~> 20.0"

#     cluster_name = local.cluster_name
#     cluster_version = "1.31"

#     create_iam_role = true
#     bootstrap_self_managed_addons = false
#     cluster_addons = {
#         coredns = {
#             most_recent = true
#         }
#         eks-pod-identity-agent = {
#             most_recent = true
#         }
#         kube-proxy = {
#             most_recent = true
#         }
#         vpc-cni = {
#             most_recent = true
#             # service_account_role_arn = aws_iam_role.vpc_cni.arn
#             configuration_values = jsonencode({
#                 env = {
#                 # Enable IPv6 (optional)
#                 ENABLE_IPv6 = "false"
#                 # Recommended settings for better pod density
#                 WARM_PREFIX_TARGET = "1"
#                 WARM_IP_TARGET    = "2"
#                 }
#             })
#         }
#     }

#     vpc_id = module.vpc_eks_dev.vpc_id
#     subnet_ids = module.vpc_eks_dev.private_subnets

#     cluster_endpoint_private_access = true
#     cluster_endpoint_public_access = true
#     enable_cluster_creator_admin_permissions = true

#     #node group
#     eks_managed_node_groups = {
#         development = {
#             ami_type       = "AL2_x86_64"
#             instance_types = ["t3.medium"]
#             min_size = 1
#             max_size = 5
#             desired_size = 1
#             subnet_ids = module.vpc_eks_dev.private_subnets
#             disk_size = 30
#             iam_role_additional_policies = {
#                 AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#             }

#             pre_bootstrap_user_data = <<-EOT
#                 #!/bin/bash
#                 set -ex
#                 # Modify kernel parameters for better networking
#                 sysctl -w net.ipv4.ip_forward=1
#                 sysctl -w net.bridge.bridge-nf-call-iptables=1
#             EOT

#             node_repair_config = {
#                 enabled = true
#             }
#         }
        
#     }
# }

module "eks_cluster" {
  source                                 = "terraform-aws-modules/eks/aws"
  version                                = "~> 20.0"

  cluster_name                           = local.cluster_name
  cluster_version                        = "1.31"
  cloudwatch_log_group_retention_in_days = 30
  cluster_endpoint_public_access         = true

  cluster_addons = {
    coredns = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
    }
    eks-pod-identity-agent = {
        most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent              = true
      service_account_role_arn = aws_iam_role.vpc_cni.arn
    }
  }

  vpc_id     = module.vpc_eks_dev.vpc_id
  subnet_ids = module.vpc_eks_dev.private_subnets
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_group_defaults = {
    ## This instance type (m6a.large) is a placeholder and will not be used in the actual deployment.

  }

  eks_managed_node_groups = {
      generalworkload-v4 = {
        min_size       = 1
        max_size       = 1
        desired_size   = 1
        instance_types = ["t3.large"]
        capacity_type  = "SPOT"
        disk_size      = 60
        ebs_optimized  = true
        iam_role_additional_policies = {
          ssm_access        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          cloudwatch_access = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
          service_role_ssm  = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
          default_policy    = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
        }
      }
    }

  cluster_security_group_additional_rules = {}

}
