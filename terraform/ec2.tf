############################
# Workload Instance
############################

resource "aws_instance" "workload" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type


  subnet_id = aws_subnet.workload_public_subnet.id


  vpc_security_group_ids = [
    aws_security_group.workload.id
  ]


  associate_public_ip_address = true


  user_data = file("${path.module}/userdata/workload.sh")


  tags = {

    Name = "Workload Instance"

    Role = "Target Environment"

  }

}



############################
# Velociraptor Server
############################

resource "aws_instance" "velociraptor_server" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type


  subnet_id = aws_subnet.sandbox_public_subnet.id


  vpc_security_group_ids = [

    aws_security_group.sandbox.id

  ]


  associate_public_ip_address = true


  user_data = file(
    "${path.module}/userdata/velociraptor_server.sh"
  )


  tags = {

    Name = "Velociraptor Server"

    Role = "DFIR Server"

  }

}



############################
# Velociraptor Client
############################

resource "aws_instance" "velociraptor_client" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type


  subnet_id = aws_subnet.sandbox_public_subnet.id


  vpc_security_group_ids = [

    aws_security_group.sandbox.id

  ]


  associate_public_ip_address = true


  user_data = file(
    "${path.module}/userdata/velociraptor_client.sh"
  )


  tags = {

    Name = "Velociraptor Client"

    Role = "DFIR Endpoint"

  }

}



############################
# Attacker Instance
############################

resource "aws_instance" "attacker" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type


  subnet_id = aws_subnet.sandbox_public_subnet.id


  vpc_security_group_ids = [

    aws_security_group.sandbox.id

  ]


  associate_public_ip_address = true


  user_data = file(
    "${path.module}/userdata/attacker.sh"
  )


  tags = {

    Name = "Attacker Instance"

    Role = "Offensive Security"

  }

}