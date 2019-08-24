provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "books-terraform"
    region = "us-west-2"
  }
}