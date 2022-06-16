output "public_ip_headnode" {
  value = module.head_node.public_ip
}

output "public_ip_networknodes" {
  value = values(module.network_nodes)[*].public_ip
}