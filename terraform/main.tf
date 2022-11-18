terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
}

############ Security Group ############
resource "aws_security_group" "app_server_sg" {
  name    = "app_server_sg"
}

############ Security Group Inbound Rules ############
resource "aws_security_group_rule" "app_server_sg_inbound_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

############ Security Group Outbound Rules ############
resource "aws_security_group_rule" "app_server_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

############ EC2 ############
resource "aws_instance" "app_server" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ "${aws_security_group.app_server_sg.id}" ]
  tags = {
    Name = "ec2-terraform"
  }
}

############ Elastic IP ############
resource "aws_eip" "app_server" {
  instance = aws_instance.app_server.id
  vpc      = true
}