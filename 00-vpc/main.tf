module "vpc" {
  source = "git::https://github.com/cekharchandra-devops/09-tf-aws-vpc-module.git?ref=main"
  project_name = var.project_name 
  environment = var.environment
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  db_subnet_cidr_blocks = var.db_subnet_cidr_blocks
  is_peering_required = var.is_peering_required
}
