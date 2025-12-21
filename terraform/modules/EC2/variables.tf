variable "CPU" {
  default = "t3.micro"
}
variable "AMI" {
    default = "ami-053b0d53c279acc90"
}
variable "KEY_NAME" {

}
locals {
  data = {
    ec2-1 = {
      name   = "compute-1"
      Project = "my-web-app"
    }
    ec2-2 = {
      name   = "compute-2"
      Project = "my-web-app"
    }
  }
}

