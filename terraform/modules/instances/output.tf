output "public_ip" {
  value = module.instances.public_ip
}

output "private_ip" {
  value = module.instances.private_ip
}