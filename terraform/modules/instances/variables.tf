variable "image_ami" {
    description = "AMI to deploy"
    type = string
}

variable "instance_type" {
    description = "Instance Type to Deploy"
    type = string
}

variable "ssh_key" {
    description = "ssh key for access"
    type = string
}

variable "availability_zone" {
   description = "Availability Zone to deploy in"
   type = string
}

variable "public_network_sg_id" {
   description = "Public Network Security Group Ids"
   type = string
}

variable "network_interfaces" {
    description = "Network Interfaces to attach"
    type = list
} 