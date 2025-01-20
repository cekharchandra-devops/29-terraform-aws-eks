data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "eks_control_plane_sg" {
  name = "/${var.project_name}/${var.environment}/eks_control_plane_sg"
}

data "aws_ssm_parameter" "node_group_sg" {
  name = "/${var.project_name}/${var.environment}/node_group_sg"
}