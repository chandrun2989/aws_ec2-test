# EC2 instance
module "EC2" {
  source                = "modules/EC2"
  VPC_ID                = data.aws_vpc.default.id
  CPU                   = var.CPU
  AMI                   = var.AMI
  KEY_NAME              = module.KEY.KEY_NAME
}
