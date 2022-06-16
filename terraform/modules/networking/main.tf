module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name                             = "${var.namespace}-vpc"
  cidr                             = var.vpc_cidr
  azs                              = var.availability_zones
  private_subnets                  = var.private_subnets
  public_subnets                   = var.public_subnets
  enable_nat_gateway               = true
}

module "public_network_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "public network ssh, http, https"
  description = "Security group for public network publicly open"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["ssh-tcp",  "https-443-tcp", "http-8080-tcp"]
  egress_rules = ["all-all"]

}

module "private_network_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "private network all open"
  description = "Security group for open traffic in private network"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = concat(var.public_subnets, var.private_subnets)
  ingress_rules            = ["all-all"]
  egress_rules = ["all-all"]

}

resource "aws_network_interface" "private_network_interface" {

  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [module.private_network_sg.security_group_id]

}

resource "aws_network_interface" "headnode_network_interface" {
  #temporary as long as all nodes public
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [module.public_network_sg.security_group_id]

}
resource "aws_network_interface" "node_network_interface" {
  #temporary as long as all nodes public net work to allow ssh and free internal flow
  for_each = var.nr_network_nodes
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [module.public_network_sg.security_group_id, module.private_network_sg.security_group_id]

}
