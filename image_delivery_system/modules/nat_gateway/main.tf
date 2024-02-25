# Elastic IP
resource "aws_eip" "nat" {
  tags = {
    Name = join("-", [var.system_name, var.environment, "natgw", var.subnet_id])
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  subnet_id = var.subnet_id
  allocation_id = aws_eip.nat.id # 紐付けるElasti IP

  tags = {
    Name = join("-", [var.system_name, var.environment, var.subnet_id])
  }
}

resource "aws_route_table" "private" {
  vpc_id              = var.vpc_id
  tags = {
    Name = join("-", [var.system_name, var.environment, var.subnet_id])
  }
}

# resource "aws_route" "main" {
#   route_table_id         = aws_route_table.main.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.nat.id
# }

resource "aws_route_table_association" "private" {
  subnet_id          = var.subnet_id
  route_table_id     = aws_route_table.private.id
}