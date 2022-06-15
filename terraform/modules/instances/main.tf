module "instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "headnode-0"

  ami                    = var.image_ami
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  monitoring             = true
  network_interface = [{
    device_index = 0
    network_interface_id = var.network_interfaces[0]
  }
  ]
  root_block_device = [{
    volume_size = 30
  }]
 
}