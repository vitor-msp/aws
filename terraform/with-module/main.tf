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
  region = "us-east-1"
}

############ EC2 ############
resource "aws_instance" "terraform_ec2" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${module.terraform_sg_module.terraform_sg_id}"]
  tags = {
    Name    = "ec2-terraform-module",
    Change  = "True",
    Desliga = "True"
  }
}

############ Elastic IP ############
resource "aws_eip" "terraform_eip" {
  instance = aws_instance.terraform_ec2.id
  vpc      = true
}

module "terraform_sg_module" {
  source = "./modules/sg"
}
