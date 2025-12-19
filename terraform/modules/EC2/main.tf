resource "aws_instance" "servers" {
  ami                    = var.AMI
  instance_type          = var.CPU
  key_name               = var.KEY_NAME
  for_each               = local.data
  tags = {
    Name = each.value.name
  }
}
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
