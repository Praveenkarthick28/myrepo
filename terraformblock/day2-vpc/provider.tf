terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
    }
    vpc = {
      source = "registry.terraform.io/hashicorp/vpc"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "terraform"
}
