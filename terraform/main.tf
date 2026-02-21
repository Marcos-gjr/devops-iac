terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "permitir_web_ssh" {
  name        = "permitir_web_ssh"
  description = "Permitir SSH e HTTP"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "servidor_devops" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t3.micro"
  key_name      = "chave-devops-iac"
  vpc_security_group_ids = [aws_security_group.permitir_web_ssh.id]
  
  tags = {
    Name = "DevOps-IaC-Server"
  }
}


output "ip_publico" {
  value = aws_instance.servidor_devops.public_ip
}