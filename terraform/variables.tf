
variable "project" {
  type        = string
  description = "Project name tag prefix"
  default     = "github-terraform-ec2"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name to use for SSH"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH Avoid 0.0.0.0/0"
  default     = "0.0.0.0/0"
  
}
variable "CPU" {
  default = "t3.micro"
}
variable "AMI" {
  default = "ami-053b0d53c279acc90"
}