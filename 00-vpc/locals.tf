locals {
  public_subnet_ids = join(",", module.vpc.public_subnet_ids)  
  private_subnet_ids = join(",", module.vpc.private_subnet_ids)  
  db_subnet_ids = join(",", module.vpc.db_subnet_ids)  
}