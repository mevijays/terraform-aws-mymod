output "ec2_ip" {
  value       = aws_instance.main.public_ip
  description = "Public ip of my ec2 instance"
}
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
}
output "subnets" {
  value       = values(aws_subnet.main)[*].id
  description = "list of the subnets created"
}
