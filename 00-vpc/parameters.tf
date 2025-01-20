resource "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
  type = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
  type = "StringList"
  value = local.public_subnet_ids
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
  type = "StringList"
  value = local.private_subnet_ids
}

resource "aws_ssm_parameter" "db_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/db_subnet_ids"
  type = "StringList"
  value = local.db_subnet_ids
}