module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 20
  }

  node_groups = {
    ng-01 = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 2

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

 map_roles = [{
      rolearn  = "arn:aws:iam::799617105972:role/AWSReservedSSO_QualiPowerUsers_98e23796b015111f"
      username = "QualiPowerUsers"
      groups   = ["system:masters"]
    },
     {
      rolearn = "arn:aws:iam::799617105972:role/qualidev2-eks2022040515083343910000000b"
      username = "qualidev2-eks2022040515083343910000000b"
      groups   = ["system:masters"]

      }] 

  map_users = [{
      userarn  = "arn:aws:iam::799617105972:user/cleanser"
      username = "cleanser"
      groups   = ["system:masters"]
    }]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
