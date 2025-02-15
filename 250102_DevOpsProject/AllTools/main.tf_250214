provider "google" {
  region = var.region
  project = var.project_name
  credentials = file(var.credentials_file_path)
}

module "vpc" {

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs = var.availability_zones
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

module "gke" {

  cluster_name = var.cluster_name
  cluster_version = var.kubernetes_version
  subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  node_groups = {
    gke_nodes = {
      desired_capacity = var.desired_capacity
      max_capacity = var.max_capacity
      min_capacity = var.min_capacity

      instance_type = var.instance_type
      key_name = var.key_name
    }
  }
}
