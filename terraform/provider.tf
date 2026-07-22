############################
# Terraform Configuration
############################

terraform {

  required_version = ">= 1.5.0"

  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "~> 5.61"

    }

  }

}


############################
# AWS Provider
############################

provider "aws" {

  profile = var.profile
  region  = var.region


  default_tags {

    tags = {

      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = var.managed_by
      Objective   = var.objective

    }

  }

}