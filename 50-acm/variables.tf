variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Terraform = true
    Project = "Expense"
    Environment = "Dev"
  }
}


variable "acm_tags" {
  default = {
    Component = "backend"
  }
}

variable "domain_name" {
  default = "devsecmlops.online"
}

variable "zone_id" {
  default = "Z081461419PCT70J0BCQ6"
}