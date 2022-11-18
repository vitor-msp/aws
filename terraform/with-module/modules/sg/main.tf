############ Security Group ############
resource "aws_security_group" "terraform_sg" {
  name    = "terraform-sg"
}

############ Security Group Inbound Rules ############
resource "aws_security_group_rule" "terraform_sg_inbound_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_sg.id
}

resource "aws_security_group_rule" "terraform_sg_inbound_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_sg.id
}

resource "aws_security_group_rule" "terraform_sg_inbound_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_sg.id
}

############ Security Group Outbound Rules ############
resource "aws_security_group_rule" "terraform_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_sg.id
}