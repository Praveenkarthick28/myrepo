terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
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
