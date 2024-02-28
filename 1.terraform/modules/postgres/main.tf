resource "aws_db_instance" "mrama_master" {
  allocated_storage    = 20
  storage_type         = var.storage_type
  engine               = "postgres"
  engine_version       = var.engine_version
  instance_class       = var.master_instance_class
  identifier = "${var.environment}-mrama-rds-master"
  username             = var.rds_username
  password             = var.rds_password

  backup_retention_period = 5
#   parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.postgres_rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "${var.environment}-mrama-rds-master"
    Project = "mrama"
  }
}

resource "aws_db_instance" "read_replica" {
  count                = var.replica_count 
  identifier           = "${var.environment}-mrama-postgres-replica-${count.index}"
  replicate_source_db  = aws_db_instance.mrama_master.identifier
  instance_class       = var.slave_instance_class
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.postgres_rds_sg.id]
#   db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  backup_retention_period = 5

  tags = {
    Name = "${var.environment}-mrama-rds-slave-${count.index + 1}"
    Project = "mrama"
  }
}

resource "aws_security_group" "postgres_rds_sg" {
  name        = "${var.environment}-mrama-postgres-rds-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [for subnet in var.subnets : subnet.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-mrama-rds-sg"
    Project = "mrama"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-mrama-rds-subnet-group"
  subnet_ids = [var.subnet_ids[0],  var.subnet_ids[1]]

  tags = {
    Name = "${var.environment}-mrama-rds-subnet-group"
    Project = "mrama"
  }
}



