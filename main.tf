

resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = { Name = "dev-vpc" }
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "main" {
  for_each          = toset(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, index(data.aws_availability_zones.available.names, each.value))
  availability_zone = each.value
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.RT_IGW
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "main" {
  for_each       = aws_subnet.main
  subnet_id      = each.value.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = toset(var.sg_ports)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = var.aws_key_name
  public_key = var.ec2_pub_key
}
data "aws_ami" "main" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "main" {
  instance_type               = var.ec2_size
  ami                         = data.aws_ami.main.id
  subnet_id                   = values(aws_subnet.main)[0].id
  security_groups             = [aws_security_group.main.id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true
  tags                        = { Name = "dev-ec2" }
}
