# Fetch default VPCs
data "aws_vpc" "default_us_east" {
  provider = aws.us_east
  default  = true
}

data "aws_vpc" "default_ap_south" {
  provider = aws.ap_south
  default  = true
}

# Security Group for US East
resource "aws_security_group" "sg_us_east" {
  provider    = aws.us_east
  name        = "allow-ssh-http-us-east"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default_us_east.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for AP South
resource "aws_security_group" "sg_ap_south" {
  provider    = aws.ap_south
  name        = "allow-ssh-http-ap-south"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default_ap_south.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance in US East
resource "aws_instance" "ec2_us_east" {
  provider               = aws.us_east
  ami                    = var.ami_us_east
  instance_type          = var.instance_type
  key_name               = var.key_name_us_east
  vpc_security_group_ids = [aws_security_group.sg_us_east.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
            EOF

  tags = {
    Name = "EC2-US-East"
  }
}

resource "aws_instance" "ec2_ap_south" {
  provider               = aws.ap_south
  ami                    = var.ami_ap_south
  instance_type          = var.instance_type
  key_name               = var.key_name_ap_south
  vpc_security_group_ids = [aws_security_group.sg_ap_south.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable nginx1
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
            EOF

  tags = {
    Name = "EC2-AP-South"
  }
}
