module "networking" {
  source    = "./modules/networking"
  availability_zones = var.availability_zones
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  namespace = var.namespace
  vpc_cidr = var.vpc_cidr
}

module "instances" {
  source     = "./modules/instances"
  image_ami = var.image_ami
  instance_type = var.instance_type
  ssh_key = var.ssh_key
  availability_zone = var.availability_zone
  public_network_sg_id = module.networking.sg_pub_id
  network_interfaces = tolist([module.networking.public_network_interface])
}