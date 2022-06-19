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

      instance_types = ["m6a.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

 map_roles = [
    {
      rolearn  = "arn:aws:iam::126030006713:role/Quali_SSO_Colonyci_Colonyusers"
      username = "PowerUsers"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::513341655526:role/Quali_Colony_Users"
      username = "QualiPowerUsers"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::608322624794:role/Quali_SSO_Colonyci2_colonyusers"
      username = "QualiPowerUsers"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::126030006713:role/TC_Agent"
      username = "PowerUsers"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::799617105972:role/AWSReservedSSO_QualiPowerUsers_98e23796b015111f"
      username = "QualiPowerUsers"
      groups   = ["system:masters"]
    },
  ]

  map_users = [
    {
      userarn  = "arn:aws:iam::799617105972:user/cleanser"
      username = "cleanser"
      groups   = ["system:masters"]
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

resource "null_resource" "iam_oidc_provider" {
  # [condition] ? [true_value] : [false_value]
  # count = var.manage_aws_auth ? 1 : 0
  provisioner "local-exec" {
    command = "eksctl utils associate-iam-oidc-provider --region=${var.aws-region} --cluster=${data.aws_eks_cluster.eks.name} --approve"
  }
}
