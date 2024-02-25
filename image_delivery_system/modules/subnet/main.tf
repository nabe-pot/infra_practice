# Subnet
resource "aws_subnet" "main" {
  vpc_id = var.vpc_id
  for_each = { for i in var.subnet_map_list : i.name => i }
  
  availability_zone = each.value.az_name
  cidr_block        = each.value.cidr
  tags = {
    Name = join("-", [var.system_name, var.environment, each.value.name])
  }
}