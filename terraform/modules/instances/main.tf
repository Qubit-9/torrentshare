module "head_node" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "headnode-0"

  #user_data              = templatefile("${path.module}/cloudinit.tmp.yml", { ssh_pub_ansible = var.server_ssh_key.public_key })
  ami                    = var.image_ami
  instance_type          = var.headnode_instance_type
  key_name               = var.ssh_key
  monitoring             = false
  network_interface = [{
    device_index = 0
    network_interface_id = var.headnode_network_interface
  }
  ]
  root_block_device = [{
    volume_size = 30
  }]
 
}


module "network_nodes" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = var.nr_network_nodes
  ami                    = var.image_ami
  instance_type          = var.node_instance_type
  key_name               = var.ssh_key
  monitoring             = false
  network_interface = [{
    device_index = 0
    network_interface_id = var.node_network_interfaces[each.key].id
  }
  ]
  root_block_device = [{
    volume_size = 30
  }]
 
}