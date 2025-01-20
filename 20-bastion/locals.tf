locals {
  resource_name = "${var.project_name}-${var.environment}"
  bastion_sg = data.aws_ssm_parameter.bastion_sg.value
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  aws_credentials = jsondecode(file(var.aws_credentials_file))
}
