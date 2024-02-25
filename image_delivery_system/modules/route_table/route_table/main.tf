# Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Name = join("-", [var.system_name, var.environment, "public"])
  }
}

# Route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}