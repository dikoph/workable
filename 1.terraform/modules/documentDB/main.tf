resource "aws_docdb_subnet_group" "mrama_docdb_subnet_group" {
  name       = "${var.environment}-mrama-docdb-subnet-group"
  subnet_ids = [var.subnet_ids[0],  var.subnet_ids[1]]  

  tags = {
    Name = "${var.environment}-mrama_docdb_subnet_group"
    Project = "mrama"
  }
}

resource "aws_docdb_cluster" "mrama_docdb" {
  cluster_identifier      = "${var.environment}-mrama"
  engine                  = "docdb"
  master_username         = var.master_username
  master_password         = var.master_password
  db_subnet_group_name    = aws_docdb_subnet_group.mrama_docdb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.mongodb_sg.id]
  skip_final_snapshot     = true

  tags = {
    Name = "${var.environment}-mrama_docdb_cluster"
    Project = "mrama"
  }
}

resource "aws_docdb_cluster_instance" "mrama_cluster_instances" {
  count              = var.instance_count  
  identifier         = "${var.environment}-${var.cluster_name}-${count.index}"
  cluster_identifier = aws_docdb_cluster.mrama_docdb.id
  instance_class     = var.db_instance_class

  tags = {
    Name = "${var.environment}-mrama_docdb_instance"
    Project = "mrama"
  }
}

resource "aws_security_group" "mongodb_sg" {
  name        = "${var.environment}-mrama-mongoDB-sg"

  vpc_id      = var.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27017
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
    Name = "${var.environment}-mrama-sg"
    Project = "mrama"
  }
}