variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {}
}

variable "bastion_tags" {
  default = {}
}

variable "aws_region" {
  type = string
  default = "us-east-1"
  
}

variable "aws_credentials_file" {
  default     = "~/.ssh/aws_credentials.json"
}