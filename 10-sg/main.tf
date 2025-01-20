module "mysql_sg" {
  source       = "git::https://github.com/cekharchandra-devops/11-tf-aws-security-group-module.git?ref=main"
  project_name = var.project_name
  vpc_id       = local.vpc_id
  environment   = var.environment
  sg_name      = "mysql"
  common_tags  = var.common_tags
  sg_tags      = var.sg_mysql_tags
}

module "node_group_sg" {
  source       = "git::https://github.com/cekharchandra-devops/11-tf-aws-security-group-module.git?ref=main"
  project_name = var.project_name
  vpc_id       = local.vpc_id
  environment   = var.environment
  sg_name      = "node-group"
  common_tags  = var.common_tags
  sg_tags      = var.node_group_sg_tags
}

module "eks_control_plane_sg" {
  source       = "git::https://github.com/cekharchandra-devops/11-tf-aws-security-group-module.git?ref=main"
  project_name = var.project_name
  vpc_id       = local.vpc_id
  environment   = var.environment
  sg_name      = "eks-control-plane"
  common_tags  = var.common_tags
  sg_tags      = var.eks_control_plane_sg_tags
}

module "bastion_sg" {
  source       = "git::https://github.com/cekharchandra-devops/11-tf-aws-security-group-module.git?ref=main"
  project_name = var.project_name
  vpc_id       = local.vpc_id
  environment   = var.environment
  sg_name      = "bastion"
  common_tags  = var.common_tags
  sg_tags      = var.bastion_sg_tags
}

module "ingress_alb_sg" {
  source       = "git::https://github.com/cekharchandra-devops/11-tf-aws-security-group-module.git?ref=main"
  project_name = var.project_name
  vpc_id       = local.vpc_id
  environment   = var.environment
  sg_name      = "ingress-alb"
  common_tags  = var.common_tags
  sg_tags      = var.ingress_alb_sg_tags
}

resource "aws_security_group_rule" "mysql_sg_node_group_sg" {
    type = "ingress"
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    source_security_group_id = module.node_group_sg.sg_id
    security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "node_group_sg_eks_control_plane_sg" {
    type = "ingress"
    protocol = "-1"
    from_port = 0
    to_port = 0
    source_security_group_id = module.eks_control_plane_sg.sg_id
    security_group_id = module.node_group_sg.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_sg_node_group_sg" {
    type = "ingress"
    protocol = "-1"
    from_port = 0
    to_port = 0
    source_security_group_id = module.node_group_sg.sg_id
    security_group_id = module.eks_control_plane_sg.sg_id
}

resource "aws_security_group_rule" "node_group_sg_ingress_alb_sg" {
    type = "ingress"
    protocol = "tcp"
    from_port = 30000
    to_port = 32767
    source_security_group_id = module.node_group_sg.sg_id
    security_group_id = module.ingress_alb_sg.sg_id
}

resource "aws_security_group_rule" "ingress_alb_sg_public" {
    type = "ingress"
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.ingress_alb_sg.sg_id
}

resource "aws_security_group_rule" "node_group_sg_vpc" {
    type = "ingress"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = module.node_group_sg.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_sg_bastion_sg" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.eks_control_plane_sg.sg_id
}

resource "aws_security_group_rule" "mysql_sg_bastion_sg_3306" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "mysql_sg_bastion_sg" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "node_group_sg_bastion_sg" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.node_group_sg.sg_id
}

resource "aws_security_group_rule" "node_group_sg_bastion_sg_8080" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    source_security_group_id = module.bastion_sg.sg_id
    security_group_id = module.node_group_sg.sg_id
}

resource "aws_security_group_rule" "bastion_sg_public" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = module.bastion_sg.sg_id
}