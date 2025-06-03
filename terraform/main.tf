# VPC for EKS
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.cluster_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3

      instance_types = ["t3.medium"]
      subnets        = module.vpc.private_subnets
    }
  }

  enable_cluster_creator_admin_permissions = true
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "helm" {
  source = "./helm"

  # Pass EKS outputs to the helm module
  cluster_name                    = module.eks.cluster_name
  cluster_endpoint                = module.eks.cluster_endpoint
  cluster_certificate_authority   = module.eks.cluster_certificate_authority_data
  aws_region                      = var.aws_region
  # Pass other variables as needed
}

# Data sources for EKS cluster connection
# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_name
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_name
# }

# Optional: Output for kubectl configuration
# output "eks_connect_command" {
#   value = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
# }
