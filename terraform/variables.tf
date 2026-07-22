############################
# AWS Configuration
############################

variable "profile" {
  description = "AWS CLI profile used by Terraform"
  type        = string
}

variable "region" {
  description = "AWS region where the laboratory will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability Zone used by the laboratory"
  type        = string
  default     = "us-east-1a"
}

############################
# Laboratory Metadata
############################

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "AWS Cloud Forensics Laboratory"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "lab"
}

variable "managed_by" {
  description = "Infrastructure management tool"
  type        = string
  default     = "Terraform"
}

variable "objective" {
  description = "Purpose of the deployment"
  type        = string
  default     = "Cloud Forensics Research"
}

############################
# Network Configuration
############################

variable "workload_vpc_cidr" {
  description = "CIDR block of the workload VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "workload_public_subnet_cidr" {
  description = "CIDR block of the workload public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "workload_private_subnet_cidr" {
  description = "CIDR block of the workload private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "sandbox_vpc_cidr" {
  description = "CIDR block of the sandbox VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "sandbox_public_subnet_cidr" {
  description = "CIDR block of the sandbox public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

############################
# EC2 Configuration
############################

variable "instance_type" {
  description = "Default EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "AWS EC2 Key Pair"
  type        = string
}

variable "admin_ip" {
  description = "Administrator public IPv4 in CIDR notation"
  type        = string
}

############################
# Velociraptor
############################

variable "velociraptor_https_port" {
  description = "Velociraptor GUI HTTPS port"
  type        = number
  default     = 8889
}

variable "velociraptor_client_port" {
  description = "Velociraptor client communication port"
  type        = number
  default     = 8000
}

############################
# Evidence Storage
############################

variable "evidence_bucket_name" {
  description = "Evidence S3 bucket name"
  type        = string
  default     = "dfir-log-archive-lab-1-carmen"
}