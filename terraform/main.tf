# EC2 instance
module "EC2" {
  source                = "./modules/EC2"
  CPU                   = var.CPU
  AMI                   = var.AMI
  KEY_NAME              = var.key_name
}
