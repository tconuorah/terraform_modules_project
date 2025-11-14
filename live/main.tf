module "network" {
  source   = "../modules/vpc"
  name     = local.name_prefix
  cidr     = local.vpc_cidr
  az_count = var.az_count
}


module "web_ec2" {
  source               = "../modules/ec2"
  name                 = local.name_prefix
  subnet_id            = module.network.public_subnet_ids[0]
  vpc_id               = module.network.vpc_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  allowed_ingress_cidr = var.allowed_ingress_cidr
}


module "db" {
  source             = "../modules/rds"
  name               = local.name_prefix
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  db_name            = var.db_name
  ec2_sg_id          = module.web_ec2.sg_id
  instance_class     = "db.t4g.micro"
}