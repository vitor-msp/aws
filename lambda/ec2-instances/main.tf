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
resource "aws_security_group" "test_lambda_sg" {
  name    = "test-lambda-sg"
}

############ Inbound Rules ############
resource "aws_security_group_rule" "test_lambda_sg_inbound_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_lambda_sg.id
}

############ Outbound Rules ############
resource "aws_security_group_rule" "test_lambda_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_lambda_sg.id
}

############ EC2 ############
resource "aws_instance" "test_lambda_ec2_01" {
  ami           = "ami-08c40ec9ead489470" # Ubuntu Server 22.04 LTS
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.test_lambda_sg.id}" ]
  tags = {
    Name = "test-lambda-ec2-01",
    LambdaTurnOff = "True"
  }
}

############ EC2 ############
resource "aws_instance" "test_lambda_ec2_02" {
  ami           = "ami-08c40ec9ead489470" # Ubuntu Server 22.04 LTS
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.test_lambda_sg.id}" ]
  tags = {
    Name = "test-lambda-ec2-02"
  }
}