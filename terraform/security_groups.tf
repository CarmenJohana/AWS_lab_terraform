####################################################
# Workload Security Group
####################################################

resource "aws_security_group" "workload_sg" {

  name        = "workload-sg"
  description = "Security group for workload resources"
  vpc_id      = aws_vpc.workload_vpc.id

  tags = {
    Name = "Workload Security Group"
  }
}

####################################################
# Workload Ingress Rules
####################################################

resource "aws_vpc_security_group_ingress_rule" "workload_ssh" {

  security_group_id = aws_security_group.workload_sg.id

  cidr_ipv4 = var.admin_ip

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"

  description = "Allow SSH from the administrator workstation"

}

# HTTP

resource "aws_vpc_security_group_ingress_rule" "workload_http" {

  security_group_id = aws_security_group.workload_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"

  description = "Allow HTTP"

}

# HTTPS

resource "aws_vpc_security_group_ingress_rule" "workload_https" {

  security_group_id = aws_security_group.workload_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  description = "Allow HTTPS"

}

####################################################
# Workload Egress Rules
####################################################

resource "aws_vpc_security_group_egress_rule" "workload_all_outbound" {

  security_group_id = aws_security_group.workload_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow all outbound traffic"

}

####################################################
# Sandbox Security Group
####################################################

resource "aws_security_group" "sandbox_sg" {

  name        = "sandbox-sg"
  description = "Security group for sandbox resources"
  vpc_id      = aws_vpc.sandbox_vpc.id

  tags = {
    Name = "Sandbox Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sandbox_ssh" {

  security_group_id = aws_security_group.sandbox_sg.id

  cidr_ipv4 = var.admin_ip

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"

  description = "Allow SSH from the administrator workstation"

}

# ICMP (Sandbox VPC internal communication)

resource "aws_vpc_security_group_ingress_rule" "sandbox_icmp" {

  security_group_id = aws_security_group.sandbox_sg.id

  cidr_ipv4 = "10.1.0.0/16"

  ip_protocol = "icmp"

  from_port = -1
  to_port   = -1

  description = "Allow ICMP within the Sandbox VPC"

}


# HTTP


resource "aws_vpc_security_group_ingress_rule" "sandbox_http" {

  security_group_id = aws_security_group.sandbox_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"

  description = "Allow HTTP"

}

# HTTPS

resource "aws_vpc_security_group_ingress_rule" "sandbox_https" {

  security_group_id = aws_security_group.sandbox_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  description = "Allow HTTPS"

}

####################################################
# Sandbox Egress Rules
####################################################

resource "aws_vpc_security_group_egress_rule" "sandbox_all_outbound" {

  security_group_id = aws_security_group.sandbox_sg.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow all outbound traffic"

}





