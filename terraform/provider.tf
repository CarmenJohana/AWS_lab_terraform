terraform {
  required_version = ">= 1.5"


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.61.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region

  default_tags {
    tags = {
	Objective = var.objective
	Project = var.cloud_forensics_lab
	ManagedBy = var.managed_by
	Environment = var.environment
    }
  }
}