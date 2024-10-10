resource "aws_subnet" "subnet_one" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets_cidr_block[0]
  availability_zone = var.availability_zone
  tags = {
    Name = var.subnet_name[0]
  }
}
resource "aws_subnet" "subnet_two" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets_cidr_block[1]
  availability_zone = var.availability_zone
  tags = {
    Name = var.subnet_name[1]
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id 

    route {
    cidr_block     = "0.0.0.0/0"  
    nat_gateway_id = "nat-0440e3c0e49d26497"
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
resource "aws_s3_bucket_policy" "raz-bucket-policy" {
  bucket = var.bucket_name
  policy = file("bucket_policy.json")
}




