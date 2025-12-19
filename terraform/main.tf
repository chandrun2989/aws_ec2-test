data "aws_vpc" "default" {
  default = true
}

# Grab subnets from the default VPC and pick one
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# EC2 instance
module "EC2" {
  source                = "../module/EC2"
  VPC_ID                = data.aws_vpc.default.id
  CPU                   = var.CPU
  AMI                   = var.AMI
  KEY_NAME              = module.KEY.KEY_NAME
}
