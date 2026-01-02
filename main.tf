provider "aws" {
  region = "ap-south-1"
}

# Security Group for SSH
resource "aws_security_group" "ssh_sg" {
  name = "ssh-access2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"

  # Attach Security Group
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "Terraform-EC2"
  }
}


