############################
# Workload Security Group
############################

resource "aws_security_group" "workload" {

  name = "workload-sg"

  description = "Security group for workload instance"

  vpc_id = aws_vpc.workload.id



  ############################
  # SSH administration
  ############################

  ingress {

    description = "SSH administration"

    from_port = 22

    to_port = 22

    protocol = "tcp"


    cidr_blocks = [
      var.admin_ip
    ]

  }



  ############################
  # Outbound Internet access
  ############################

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"


    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }



  tags = {

    Name = "workload-sg"

  }

}



############################
# Sandbox Security Group
############################

resource "aws_security_group" "sandbox" {

  name = "sandbox-sg"


  description = "Security group for DFIR sandbox environment"


  vpc_id = aws_vpc.sandbox.id



  ############################
  # SSH administration
  ############################

  ingress {

    description = "SSH administration"


    from_port = 22

    to_port = 22


    protocol = "tcp"


    cidr_blocks = [
      var.admin_ip
    ]

  }



  ############################
  # Velociraptor Web UI
  ############################

  ingress {

    description = "Velociraptor HTTPS interface"


    from_port = 8889

    to_port = 8889


    protocol = "tcp"


    cidr_blocks = [
      var.admin_ip
    ]

  }



  ############################
  # Velociraptor client communication
  ############################

  ingress {

    description = "Velociraptor client communication"


    from_port = 8000

    to_port = 8000


    protocol = "tcp"


    cidr_blocks = [
      aws_vpc.sandbox.cidr_block
    ]

  }



  ############################
  # Optional Velociraptor GUI
  ############################

  ingress {

    description = "Velociraptor frontend HTTPS"


    from_port = 8889

    to_port = 8889


    protocol = "tcp"


    cidr_blocks = [
      aws_vpc.sandbox.cidr_block
    ]

  }



  ############################
  # Outbound Internet
  ############################

  egress {

    from_port = 0

    to_port = 0


    protocol = "-1"


    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }



  tags = {

    Name = "sandbox-sg"

  }

}