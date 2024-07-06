terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
    vpc = {
      source = "hashicorp/vpc"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "terraform"
}
