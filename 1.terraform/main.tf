module "vpc_module" {
  # count = var.create_vpc ? 1 : 0
  source        = "./modules/vpc"
  environment   = var.environment
  create_vpc = var.create_vpc
  existing_vpc_id = var.existing_vpc_id
  vpc_name = var.vpc_name
  cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets 
  private_subnets = var.private_subnets

}

module "passwords" {
  source = "./modules/passwords"
  environment = var.environment
}

module "mongodb_module"{
  count = var.managed_mondoDB ? 0 : 1
  source        = "./modules/mongoDB"
  environment = var.environment
  vpc_id = module.vpc_module.vpc_id
  subnets = var.private_subnets
  mongoDB_nodes_coount = var.mongoDB_nodes_coount
  mongoDB_ami = var.mongoDB_ami
  mongoDB_instance_type = var.mongoDB_instance_type
  subnet_ids=module.vpc_module.private_subnets
}

module "documentdb_module"{
  count = var.managed_mondoDB ? 1 : 0
  source        = "./modules/documentDB"
  environment = var.environment
  vpc_id = module.vpc_module.vpc_id
  cluster_name = var.cluster_name
  master_username = var.master_username
  master_password = jsondecode(data.aws_secretsmanager_secret_version.documentdb_password_secret.secret_string)["password"]
  # vpc_security_group_ids = module.vpc_module
  instance_count = var.instance_count
  subnet_ids = module.vpc_module.private_subnets
  db_subnet_group_name = "Test"
  subnets = var.private_subnets
  db_instance_class = var.db_instance_class
}

module "postgres_module"{
  source        = "./modules/postgres"
  environment = var.environment
  vpc_id = module.vpc_module.vpc_id

  rds_username = var.rds_username
  rds_password = jsondecode(data.aws_secretsmanager_secret_version.postgres_password_secret.secret_string)["password"]
  # vpc_security_group_ids = module.vpc_module
  replica_count = var.replica_count
  subnets = var.private_subnets
  storage_type = var.storage_type
  engine_version = var.engine_version
  master_instance_class = var.master_instance_class
  slave_instance_class = var.slave_instance_class
  subnet_ids = module.vpc_module.private_subnets
}