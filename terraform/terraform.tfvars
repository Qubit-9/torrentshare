#aws
region = "eu-west-1"

# vpc
namespace = "distributed_test_env"
availability_zones = ["eu-west-1b"]
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.0.0/20"]
private_subnets = ["10.0.128.0/20"]

# instances

image_ami = "ami-06bc01540a677d796"
headnode_instance_type = "t3a.large"
node_instance_type = "t3a.medium"
ssh_key = "mj-torrent"
availability_zone = "eu-west-1b"
nr_network_nodes = 2