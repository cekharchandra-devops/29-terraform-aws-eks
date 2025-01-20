data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "ingress_alb_sg" {
  name = "/${var.project_name}/${var.environment}/ingress_alb_sg"
}

data "aws_ssm_parameter" "aws_acm_certificate_arn" {
  name  = "/${var.project_name}/${var.environment}/aws_acm_certificate_arn"
}
