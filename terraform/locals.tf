############################
# Resource Names
############################

locals {

  # VPCs
  workload_vpc_name = "workload-vpc"
  sandbox_vpc_name  = "sandbox-vpc"

  # Subnets
  workload_public_subnet_name  = "workload-public-subnet"
  workload_private_subnet_name = "workload-private-subnet"
  sandbox_public_subnet_name   = "sandbox-public-subnet"

  # Internet Gateways
  workload_igw_name = "workload-igw"
  sandbox_igw_name  = "sandbox-igw"

  # Route Tables
  workload_public_rt_name  = "workload-public-rt"
  workload_private_rt_name = "workload-private-rt"
  sandbox_public_rt_name   = "sandbox-public-rt"

  # Security Groups
  workload_sg_name = "workload-sg"
  sandbox_sg_name  = "sandbox-sg"

  # EC2 Instances
  workload_instance_name            = "workload-instance"
  attacker_instance_name            = "attacker-instance"
  velociraptor_server_instance_name = "velociraptor-server"
  velociraptor_client_instance_name = "velociraptor-client"

  # S3
  evidence_bucket_name = var.evidence_bucket_name

  # CloudTrail
  cloudtrail_name = "cloud-forensics-trail"

}