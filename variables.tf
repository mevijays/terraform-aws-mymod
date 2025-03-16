variable "aws_vpc_cidr" {
  default     = "192.168.0.0/16"
  type        = string
  description = "aws vpc cidr to create as string"
}
variable "sg_ports" {
  default     = [80, 22, 443]
  type        = list(number)
  description = "list of ingress ports to be open for security group"
}
variable "RT_IGW" {
  default     = "0.0.0.0/0"
  type        = string
  description = "internet gateway source cidr range as string"
}

variable "aws_key_name" {
  default     = "ubuntu"
  type        = string
  description = " the ssh key name for ec2 authenticatiopn public key"
}
variable "ec2_pub_key" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5QqtH1y7NC/jJ8pOGzeQ90n8XuESQ+JMQovkhS/CFdGeh2Il0KDgFWvbxrkVUlnPEHCSTKEm92jLXfhlzGxX/5KSgkzRAgOQpsCP29nvjcFMVoyErcVen0KrQmhf7njg92lQIEyymNGNhd8b5gONXxHd0PpsOMT5wtvt9CZoN8aJu32+JT844xljp9tyirgptyJQdcjqb/rNKPh5vrRcPF4gRcQEMXRtLiXJfZ6Mg67/rLYO6oDrZSApG5oyS+JZx/g/mEuGeeVkOF+Ivc8Iq0AiWewJrjb/8e93lH14x5LaURkhZmRKIQfk7Fg5BRzIgboJBf8MvEDsBoftaOx2r vijay@virus"
  type        = string
  description = "the public key content string"
}
variable "ec2_size" {
  default     = "t2.micro"
  type        = string
  description = "the ec2 size instance you want to create"
}
