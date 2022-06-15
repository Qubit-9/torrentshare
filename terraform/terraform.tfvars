#aws
region = "eu-west-1"

# vpc
namespace = "distributed_test_env"
availability_zones = ["eu-west-1b"]
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.0.0/20"]
private_subnets = ["10.0.128.0/20"]

# instances

image_ami = "ami-03854b270a4855174"
instance_type = "t3a.large"
ssh_key = "mj-torrent"
availability_zone = "eu-west-1b"