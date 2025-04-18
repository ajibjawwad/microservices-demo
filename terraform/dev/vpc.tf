module "vpc_eks_dev" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "5.19.0"

    name = "${local.cluster_name}-dev-vpc"
    cidr = "10.11.0.0/16"

    azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
    private_subnets     = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
    public_subnets      = ["10.11.101.0/24", "10.11.102.0/24", "10.11.103.0/24"]
    database_subnets    = ["10.11.201.0/24", "10.11.202.0/24", "10.11.203.0/24"]

    enable_nat_gateway      = true
    single_nat_gateway      = true
    one_nat_gateway_per_az  = false
    enable_dns_hostnames    = true
    enable_dns_support      = true

    tags = {
        terraform   = "true"
        Environment = local.environment
    }
    private_subnet_tags = {
        "Name"                                          = "${local.cluster_name}-private-subnet"
        "kubernetes.io/role/internal-elb"             = "1"
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    }

    public_subnet_tags = {
        "Name"                                          = "${local.cluster_name}-public-subnet"
        "kubernetes.io/role/elb"                        = "1"
        "kubernetes.io/cluster/${local.cluster_name}"   = "shared"

    }
}
