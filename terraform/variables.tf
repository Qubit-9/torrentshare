variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}
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

variable "vpc_cidr" {
   description = "CIDR for VPC"
   type = string
}

variable "availability_zone" {
   description = "Availability Zone to deploy in"
   type = string
}

variable "availability_zones" {
   description = "Availability Zones for VPC to deploy in"
   type = list
}

  variable "public_subnets" {
   description = "list of public subnets"
   type = list
 }
  variable "private_subnets" {
   description = "list of private subnets"
   type = list
 }

   variable "region" {
   description = "aws region"
   type = string
 }

 variable "nr_network_nodes" {
   description = "Amount of network nodes"
   type = number
}

#variable "server_ssh_key" {
#  sensitive = true
#}

