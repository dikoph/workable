variable "region" {}
variable "environment" {}

variable "vpc_name" {}

#create or reuse existing vpc
variable "create_vpc" {
    type=bool
}
variable "existing_vpc_id" {}

variable "vpc_cidr_block" {}
variable "public_subnets" {}
variable "private_subnets" {}

# modgoDB
variable "mongoDB_nodes_coount" {}
variable "mongoDB_ami" {}
variable "mongoDB_instance_type" {}

# deploy managed mongoDB
variable "managed_mondoDB" {
    type=bool
}

# documentDB
variable "cluster_name" {}
variable "master_username" {}
variable "db_instance_class" {}
variable "instance_count" {}

#rds postgres
variable "rds_username" {}
variable "replica_count" {}
variable "storage_type" {}
variable "engine_version" {}
variable "master_instance_class" {}
variable "slave_instance_class" {}

