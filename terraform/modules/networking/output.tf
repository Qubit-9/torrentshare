output "vpc" {
  value = module.vpc
}

output "sg_pub_id" {
  value = module.public_network_sg.security_group_id
}

output "sg_priv_id" {
  value = module.private_network_sg.security_group_id
}

output "headnode_network_interface" {
  value = aws_network_interface.headnode_network_interface.id
}

output "private_network_interface" {
  value = aws_network_interface.private_network_interface.id
}

output "node_network_interfaces" {
  value = values(aws_network_interface.node_network_interface)[*]
}
