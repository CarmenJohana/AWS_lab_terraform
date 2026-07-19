resource "aws_vpc" "workload_vpc" {
	cidr_block	= "10.0.0.0/16"
	tags = {
		Name = "Workload VPC"
	}
}

resource "aws_internet_gateway" "workload_ig" {
	vpc_id = aws_vpc.workload_vpc.id
	tags = {
		Name = "Workload Internet Gateway"
	}

}

resource "aws_subnet" "workload_public_subnet" {
	availability_zone 	= var.availability_zone
	cidr_block		= "10.0.1.0/24"
	vpc_id			= aws_vpc.workload_vpc.id
	map_public_ip_on_launch	= true
	tags = {
		Name = "Workload Public Subnet"
	}
}

resource "aws_route_table" "workload_public_rt" {
	vpc_id	= aws_vpc.workload_vpc.id
	route {
		cidr_block	= "0.0.0.0/0"
		gateway_id	= aws_internet_gateway.workload_ig.id
	}
	tags = {
		Name = "Route table for workload public subnet"
	}
}

resource "aws_route_table_association" "workload_public_rt_association" {
	
	subnet_id	= aws_subnet.workload_public_subnet.id
	route_table_id	= aws_route_table.workload_public_rt.id

}

resource "aws_subnet" "workload_private_subnet" {
	availability_zone 	= var.availability_zone
	cidr_block		= "10.0.2.0/24"
	vpc_id			= aws_vpc.workload_vpc.id
	tags = {
		Name = "Workload Private Subnet"
	}
}

resource "aws_vpc" "sandbox_vpc" {
	cidr_block	= "10.1.0.0/16"
	tags = {
		Name = "Sandbox VPC"
	}
}

resource "aws_internet_gateway" "sandbox_ig" {
	vpc_id = aws_vpc.sandbox_vpc.id
	tags = {
		Name = "Sandbox Internet Gateway"
	}

}

resource "aws_subnet" "sandbox_public_subnet" {
	availability_zone 	= var.availability_zone
	cidr_block		= "10.1.1.0/24"
	vpc_id			= aws_vpc.sandbox_vpc.id
	map_public_ip_on_launch	= true
	tags = {
		Name = "Sandbox Public Subnet"
	}
}

resource "aws_route_table" "sandbox_public_rt" {
	vpc_id	= aws_vpc.sandbox_vpc.id
	route {
		cidr_block	= "0.0.0.0/0"
		gateway_id	= aws_internet_gateway.sandbox_ig.id
	}
	tags = {
		Name = "Route table for sandbox public subnet"
	}
}

resource "aws_route_table_association" "sandbox_public_rt_association" {
	
	subnet_id	= aws_subnet.sandbox_public_subnet.id
	route_table_id	= aws_route_table.sandbox_public_rt.id

}