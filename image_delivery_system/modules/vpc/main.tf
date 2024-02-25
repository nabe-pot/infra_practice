resource "aws_vpc" "main" {
  cidr_block                           = var.vpc_cidr
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    Name = join("-", [var.system_name, var.environment])
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = join("-", [var.system_name, var.environment])
  }
}