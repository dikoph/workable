resource "aws_vpc" "mrama_vpc" {
  count      = var.create_vpc ? 1 : 0
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}-${var.environment}"
    Project = "mrama"
  }
}

locals {
  vpc_id = var.create_vpc ? aws_vpc.mrama_vpc[0].id : var.existing_vpc_id
}

resource "aws_internet_gateway" "mrama_gateway" {
  count      = var.create_vpc ? 1 : 0
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.environment}-mrama_gateway"
    Project = "mrama"
  }
}

data "aws_internet_gateway" "existing_igw" {
  count = var.create_vpc ? 0 : 1
  filter {
    name   = "attachment.vpc-id"
    values = [local.vpc_id]
  }
}

locals {
  igw_id = var.create_vpc ? aws_internet_gateway.mrama_gateway[0].id : data.aws_internet_gateway.existing_igw[0].id
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id            = local.vpc_id
  cidr_block        = var.public_subnets[count.index].cidr
  availability_zone = var.public_subnets[count.index].az

  tags = {
    Name        = "${var.environment}-public-${var.public_subnets[count.index].az}"
    Project = "mrama"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].az

  tags = {
    Name        = "${var.environment}-private-${var.private_subnets[count.index].az}"
    Project = "mrama"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.igw_id
  }

  tags = {
    Name = "${var.environment}-mrama-public_route_table"
    Project = "mrama"
  }
}

resource "aws_route_table_association" "public_route_table_assoc1" {
  count = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
