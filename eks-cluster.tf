module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }
  # eks_managed_node_groups = {
  #   blue = {}
  #   green = {
  #     min_size     = 1
  #     max_size     = 3
  #     desired_size = 2

  #     instance_types = ["t3.medium"]
  #     labels = {
  #       Environment = "test"
  #       GithubRepo  = "terraform-aws-eks"
  #       GithubOrg   = "terraform-aws-modules"
  #     }
      
  #     tags = {
  #       ExtraTag = "example"
  #     }
  #   }
  # }
}

# module "eks_node_group_heavy" {
#   source = "cloudposse/eks-node-group/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   # version     = "x.x.x"

#   instance_types        = [ "t3.medium" ]
#   subnet_ids            = module.vpc.private_subnets
#   min_size              = 1
#   max_size              = 1
#   desired_size          = 1
#   cluster_name          = module.eks.cluster_id
#   create_before_destroy = true
#   kubernetes_version    = [ "1.20" ]
#   name                  = "heavy"
#   depends_on = [
#     module.eks
#   ]
#   # Ensure the cluster is fully created before trying to add the node group
#   #module_depends_on = [module.eks.aws_auth_configmap_yaml]
# }

module "eks_node_group_small" {
  source = "cloudposse/eks-node-group/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"

  instance_types        = [ "t3.small" ]
  subnet_ids            = module.vpc.private_subnets
  min_size              = 2
  max_size              = 3
  desired_size          = 2
  cluster_name          = module.eks.cluster_id
  create_before_destroy = true
  kubernetes_version    = [ "1.20" ]
  name                  = "small"
  depends_on = [
    module.eks
  ]
  # Ensure the cluster is fully created before trying to add the node group
  #module_depends_on = [module.eks.aws_auth_configmap_yaml]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
