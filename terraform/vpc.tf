############################
# Workload VPC
############################

resource "aws_vpc" "workload" {

  cidr_block = var.workload_vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {

    Name = local.workload_vpc_name

  }

}


############################
# Workload Internet Gateway
############################

resource "aws_internet_gateway" "workload" {

  vpc_id = aws_vpc.workload.id

  tags = {

    Name = local.workload_igw_name

  }

}


############################
# Sandbox VPC
############################

resource "aws_vpc" "sandbox" {

  cidr_block = var.sandbox_vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {

    Name = local.sandbox_vpc_name

  }

}


############################
# Sandbox Internet Gateway
############################

resource "aws_internet_gateway" "sandbox" {

  vpc_id = aws_vpc.sandbox.id

  tags = {

    Name = local.sandbox_igw_name

  }

}