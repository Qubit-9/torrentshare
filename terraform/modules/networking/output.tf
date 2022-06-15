output "vpc" {
  value = module.vpc
}

output "sg_pub_id" {
  value = module.public_network_sg.security_group_id
}

output "sg_priv_id" {
  value = module.private_network_sg.security_group_id
}

output "public_network_interface" {
  value = aws_network_interface.public_network_interface.id
}

output "private_network_interface" {
  value = aws_network_interface.private_network_interface.id
}