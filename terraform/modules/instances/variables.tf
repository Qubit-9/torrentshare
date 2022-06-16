variable "image_ami" {
    description = "AMI to deploy"
    type = string
}

variable "headnode_instance_type" {
    description = "Instance Type to Deploy"
    type = string
}

variable "node_instance_type" {
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

variable "headnode_network_interface" {
    description = "Network Interfaces to attach to Headnode"
    type = string
} 

variable "node_network_interfaces" {
    description = "Network Interfaces to attach to Network Nodes"
    type = list
} 

variable "nr_network_nodes" {
   description = "Amount of network nodes"
   type = set(string)
}

#" {
#  sensitive = true
#}