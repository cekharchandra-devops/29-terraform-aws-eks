locals {
  resource_name = "${var.project_name}-${var.environment}"
  public_subnet_ids = split(",",data.aws_ssm_parameter.public_subnet_ids.value)
  ingress_alb_sg_id = data.aws_ssm_parameter.ingress_alb_sg.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}