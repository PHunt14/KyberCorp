provider "aws" {
    region = "us-east-1"
  
}

resource "aws_vpc" "kybercorp_dev_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
  
}

resource "aws_subnet" "kybercorp_dev_subnet" {
    count = 2
    vpc_id = aws_vpc.kybercorp_dev_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  
}

resource "aws_iam_role" "eks_cluster_role" {
    name = "kybercorp-dev-eks-cluster-role"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
        {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
        }
        ]
    }
EOF
}

resource "aws_eks_cluster" "kybercorp_dev_eks" {
    name = "kybercorp_dev"
    role_arn = aws_iam_role.eks_cluster_role.arn

    vpc_config {
      subnet_ids = aws_iam_role.eks_cluster_role[*].id
    }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Output commands to configure kubectl
output "kubeconfig_commands" {
  value = module.eks_cluster.kubeconfig_commands
}