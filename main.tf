locals {
  name_prefix = "${var.cluster_name}-${var.env}"
}

# -------- VPC --------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1" # latest as of Jun 2025

  name = "${local.name_prefix}-vpc"
  cidr = "10.20.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}


# -------- EKS --------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.1.3" # pin for repeatability

  name               = local.name_prefix
  kubernetes_version = var.k8s_version

  # Adds your caller as cluster-admin via EKS Access Entries (no manual aws-auth)
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # Core EKS add-ons (Amazon-managed)
  # - Install coredns/kube-proxy/vpc-cni as managed add-ons
  # - Install Pod Identity agent so you can use EKS Pod Identity
  addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = { before_compute = true }
    eks-pod-identity-agent = { before_compute = true }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    gp = {
      instance_types = var.node_instance_types
      ami_type       = "AL2023_x86_64_STANDARD" # default for recent k8s on EKS
      min_size       = 2
      max_size       = 6
      desired_size   = 3
    }
  }
}


# Example: output the cluster essentials
output "cluster_name" { value = module.eks.cluster_name }
output "cluster_arn" { value = module.eks.cluster_arn }
output "cluster_version" { value = module.eks.cluster_version }
output "oidc_provider_arn" { value = module.eks.oidc_provider_arn }
output "node_group_names" { value = module.eks.eks_managed_node_groups }



