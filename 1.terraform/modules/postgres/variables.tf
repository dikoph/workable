variable "rds_username" {}
variable "rds_password" {
    sensitive   = true
}
variable "environment" {}
variable "replica_count" {}
variable "vpc_id" {}
variable "subnets" {}
variable "subnet_ids" {}
variable "storage_type" {}
variable "engine_version" {}
variable "master_instance_class" {}
variable "slave_instance_class" {}