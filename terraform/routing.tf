############################
# Workload Public Subnet
############################

resource "aws_subnet" "workload_public" {

  vpc_id = aws_vpc.workload.id

  cidr_block = var.workload_public_subnet_cidr

  availability_zone = var.availability_zone

  map_public_ip_on_launch = true

  tags = {

    Name = local.workload_public_subnet_name

  }

}


############################
# Workload Private Subnet
############################

resource "aws_subnet" "workload_private" {

  vpc_id = aws_vpc.workload.id

  cidr_block = var.workload_private_subnet_cidr

  availability_zone = var.availability_zone

  map_public_ip_on_launch = false

  tags = {

    Name = local.workload_private_subnet_name

  }

}


############################
# Workload Public Route Table
############################

resource "aws_route_table" "workload_public" {

  vpc_id = aws_vpc.workload.id


  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.workload.id

  }


  tags = {

    Name = local.workload_public_rt_name

  }

}


############################
# Workload Private Route Table
############################

resource "aws_route_table" "workload_private" {

  vpc_id = aws_vpc.workload.id


  route {

    cidr_block = var.workload_vpc_cidr

    gateway_id = "local"

  }


  tags = {

    Name = local.workload_private_rt_name

  }

}


############################
# Workload Public Route Association
############################

resource "aws_route_table_association" "workload_public" {

  subnet_id = aws_subnet.workload_public.id

  route_table_id = aws_route_table.workload_public.id

}


############################
# Workload Private Route Association
############################

resource "aws_route_table_association" "workload_private" {

  subnet_id = aws_subnet.workload_private.id

  route_table_id = aws_route_table.workload_private.id

}


############################
# Sandbox Public Subnet
############################

resource "aws_subnet" "sandbox_public" {

  vpc_id = aws_vpc.sandbox.id

  cidr_block = var.sandbox_public_subnet_cidr

  availability_zone = var.availability_zone

  map_public_ip_on_launch = true


  tags = {

    Name = local.sandbox_public_subnet_name

  }

}


############################
# Sandbox Public Route Table
############################

resource "aws_route_table" "sandbox_public" {

  vpc_id = aws_vpc.sandbox.id


  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.sandbox.id

  }


  tags = {

    Name = local.sandbox_public_rt_name

  }

}


############################
# Sandbox Public Route Association
############################

resource "aws_route_table_association" "sandbox_public" {

  subnet_id = aws_subnet.sandbox_public.id

  route_table_id = aws_route_table.sandbox_public.id

}