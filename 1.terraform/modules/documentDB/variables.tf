variable "environment" {}
variable "vpc_id" {}
variable "cluster_name" {}
variable "master_username" {}
variable "master_password" {
  sensitive   = true
}
variable "db_subnet_group_name" {}
variable "db_instance_class" {
  default     = "db.t3.medium"
}
variable "instance_count" {}
variable "subnet_ids" {}
variable "subnets" {}