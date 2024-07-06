terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.17.8"
    }
  }
}
provider "aws"{
  region = "us-east-1"
  profile= "terraform"
  }
