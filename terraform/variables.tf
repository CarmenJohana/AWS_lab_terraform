variable "profile" {
	description 	= "The AWS profile to use"
	type		= string
}

variable "region" {
	default	= "us-east-1"
	type	= string
}

variable "objective" {
	description 	= "Objective of this project"
	default 	= "Cloud forensics research"
	type		= string
}

variable "cloud_forensics_lab" {
	description = "Name or identifier of the cloud forensics laboratory project"
	default     = "AWS Cloud Forensics Research Lab"
	type        = string
}

variable "environment" {
	description = "Deployment environment identifier"
	default     = "lab"
	type        = string
}

variable "managed_by" {
	description = "Tool or process used to manage the infrastructure"
	default     = "Terraform"
	type        = string
}


variable "availability_zone" {
	default	= "us-east-1a"
	type	= string
}

variable "admin_ip" {
  description = "Public IPv4 address allowed to administer the laboratory (CIDR notation)"
  type        = string
}