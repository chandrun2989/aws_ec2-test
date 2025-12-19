output "instance_id" {
  description = "EC2 Instance ID"
  value       = { for k, v in aws_instance.servers : k => v.id }
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = { for k, v in aws_instance.servers : k => v.public_ip }
}

output "public_dns" {
  description = "EC2 Public DNS"
  value       = { for k, v in aws_instance.servers : k => v.public_dns }
}