terraform {
  backend "s3" {
    bucket = var.bucket
    region = "us-east-1"
    key = var.key
    encryption = true
    dyname_table = "terraform_lock"
  }
}
