# Stores the subnets ID`s and routetable ID after they are created
locals {
  subnet_ids = [
    aws_subnet.subnet_one.id,
    aws_subnet.subnet_two.id
  ]
  route_table_id = aws_route_table.route_table.id
  }
