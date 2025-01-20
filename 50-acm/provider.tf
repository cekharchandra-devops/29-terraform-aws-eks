terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
  backend "s3" {
    bucket         = "expense-infra-remote-state-dev"
    key            = "expense-dev-eks-acm"
    region         = "us-east-1"
    dynamodb_table = "expense-remote-state-locking"
  }
}
provider "aws" {
  region = "us-east-1"
}