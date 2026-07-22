############################
# AWS Region
############################

data "aws_region" "current" {}

############################
# AWS Account
############################

data "aws_caller_identity" "current" {}

############################
# AWS Partition
############################

data "aws_partition" "current" {}

############################
# Amazon Linux 2023 AMI
############################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}