resource "aws_ssm_parameter" "mysql_sg" {
  name = "/${var.project_name}/${var.environment}/mysql_sg"
  type = "String"
  value = module.mysql_sg.sg_id
}

resource "aws_ssm_parameter" "node_group_sg" {
  name = "/${var.project_name}/${var.environment}/node_group_sg"
  type = "String"
  value = module.node_group_sg.sg_id
}

resource "aws_ssm_parameter" "eks_control_plane_sg" {
  name = "/${var.project_name}/${var.environment}/eks_control_plane_sg"
  type = "String"
  value = module.eks_control_plane_sg.sg_id
}

resource "aws_ssm_parameter" "ingress_alb_sg" {
  name = "/${var.project_name}/${var.environment}/ingress_alb_sg"
  type = "String"
  value = module.ingress_alb_sg.sg_id
}

resource "aws_ssm_parameter" "bastion_sg" {
  name = "/${var.project_name}/${var.environment}/bastion_sg"
  type = "String"
  value = module.bastion_sg.sg_id
}