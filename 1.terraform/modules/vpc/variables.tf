variable "environment" {}
variable "vpc_name" {}
variable "create_vpc" {
    type=bool
}
variable "existing_vpc_id" {}
variable "cidr_block" {}
variable "public_subnets" {}
variable "private_subnets" {}