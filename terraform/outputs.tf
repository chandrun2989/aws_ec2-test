
output "instance_id" {
  description = "EC2 Instance ID"
  value       = module.EC2.instance_id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = module.EC2.public_ip
}

output "public_dns" {
  description = "EC2 Public DNS"
  value       = module.EC2.public_dns
}