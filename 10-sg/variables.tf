variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {}
}

variable "sg_mysql_tags" {
  default = {}
}

variable "node_group_sg_tags" {
  default = {}
}

variable "eks_control_plane_sg_tags" {
  default = {}
}

variable "ingress_alb_sg_tags" {
  default = {}
}

variable "bastion_sg_tags" {
  default = {}
}