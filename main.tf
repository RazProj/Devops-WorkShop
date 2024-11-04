resource "aws_subnet" "subnet_one" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets_cidr_block[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = var.subnet_name[0]
  }
}
resource "aws_subnet" "subnet_two" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets_cidr_block[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = var.subnet_name[1]
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  # An outbound route to the Interent via NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.NAT_Gateway_ID
  }


  tags = {
    Name = var.routetable_name
  }
}
resource "aws_route_table_association" "associate_subnet_one" {
  subnet_id      = local.subnet_ids[0]
  route_table_id = local.route_table_id
}
resource "aws_route_table_association" "associate_subnet_two" {
  subnet_id      = local.subnet_ids[1]
  route_table_id = local.route_table_id
}
# Defining a s3 bucket policy which allows only self user access
resource "aws_s3_bucket_policy" "raz-bucket-policy" {
  bucket = var.bucket_name
  policy = file("bucket_policy.json")
}
# Associating the EKS Admin policy to the user`s in user.arn list and defining the access scope
resource "aws_eks_access_policy_association" "eks_user_access" {
  for_each = toset(var.users_arn)

  cluster_name  = var.cluster_name
  principal_arn = each.value
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
  depends_on = [module.eks]

}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = var.vpc_id
  subnet_ids                     = local.subnet_ids
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns               = "v1.11.3-eksbuild.1"
    aws-ebs-csi-driver    = "v1.36.0-eksbuild.1"
  }

  eks_managed_node_group_defaults = {
    instance_types = [var.instance_type]
  }
  eks_managed_node_groups = {
    raz-nodegroup = {
      desired_size  = 2
      max_size      = 3
      min_size      = 1
      instance_type = var.instance_type
    }
  }
access_entries = {
  for index, arn in toset(var.users_arn) : index => {
    principal_arn    = arn   
  } 
}
}

resource "aws_route53_record" "example" {
  zone_id = var.hosted_zone_id
  name    = "raz.wix-devops-workshop.com" 
  type    = "CNAME"                      
  ttl     = 60                       
  records = ["a212245d498974968a7fa6f9ac4c003f-5f9b757e13cbbde9.elb.eu-west-1.amazonaws.com"]     
}




