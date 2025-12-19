resource "aws_instance" "servers" {
  ami                    = var.AMI
  instance_type          = var.CPU
  key_name               = var.KEY_NAME
  for_each               = local.data
  tags = {
    Name = each.value.name
  }
}