module "networking" {
  source    = "./modules/networking"
  availability_zones = var.availability_zones
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  namespace = var.namespace
  vpc_cidr = var.vpc_cidr
  nr_network_nodes = toset(range(tostring(var.nr_network_nodes)))

}

module "instances" {
  source     = "./modules/instances"
  image_ami = var.image_ami
  headnode_instance_type = var.headnode_instance_type
  node_instance_type = var.node_instance_type
  ssh_key = var.ssh_key
  availability_zone = var.availability_zone
  public_network_sg_id = module.networking.sg_pub_id
  headnode_network_interface = module.networking.headnode_network_interface
  node_network_interfaces = module.networking.node_network_interfaces
  nr_network_nodes = toset(range(tostring(var.nr_network_nodes)))
}