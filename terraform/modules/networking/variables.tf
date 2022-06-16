 variable "availability_zones" {
   description = "list of availability zones"
   type = list
   default = ["eu-west-1"]
 }

  variable "public_subnets" {
   description = "list of public subnets"
   type = list
 }
  variable "private_subnets" {
   description = "list of private subnets"
   type = list
 }

 variable "namespace" {
   description = "namespace to deploy in"
   type = string
}

variable "vpc_cidr" {
   description = "CIDR for VPC"
   type = string
}

variable "nr_network_nodes" {
   description = "Amount of network nodes"
   type = set(string)
}