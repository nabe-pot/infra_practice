module "vpc" {
  source      = "../../modules/vpc"
  environment = "dev"
  system_name = "image_delivery_system"
  vpc_cidr    = "172.32.0.0/16"
}

module "public_subnet" {
  source      = "../../modules/subnet"
  vpc_id      = module.vpc.vpc_id
  environment = "dev"
  system_name = "image_delivery_system"
  subnet_map_list = [
    { "name" = "public-1a", "cidr" = "172.32.1.0/24", "az_name" = "us-east-1a" },
    { "name" = "public-1c", "cidr" = "172.32.2.0/24", "az_name" = "us-east-1c" },
    { "name" = "public-1d", "cidr" = "172.32.3.0/24", "az_name" = "us-east-1d" },
  ]
}
module "private_subnet" {
  source      = "../../modules/subnet"
  vpc_id      = module.vpc.vpc_id
  environment = "dev"
  system_name = "image_delivery_system"
  subnet_map_list = [
    { "name" = "private-1a", "cidr" = "172.32.4.0/24", "az_name" = "us-east-1a" },
    { "name" = "private-1c", "cidr" = "172.32.5.0/24", "az_name" = "us-east-1c" },
    { "name" = "private-1d", "cidr" = "172.32.6.0/24", "az_name" = "us-east-1d" },
  ]
}

module "route_table_public" {
  source              = "../../modules/route_table/route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  environment         = "dev"
  system_name         = "image_delivery_system"
}

module "route_table_association_public" {
  source         = "../../modules/route_table/route_table_association"
  route_table_id = module.route_table_public.route_table_id
  for_each       = module.public_subnet.subnets
  subnet_id      = each.value
}

module "nat_gateway" {
  source         = "../../modules/nat_gateway"
  # for_each       = module.public_subnet.subnets
  # subnet_id      = each.value
  subnet_id      = module.public_subnet.subnets["us-east-1a"]
  vpc_id         = module.vpc.vpc_id
  environment    = "dev"
  system_name    = "image_delivery_system"
}