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

resource "aws_iam_role" "ssm_role" {
  name = "${var.environment}-mrama-ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.environment}-mrama-ssm_instance_profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "mongodb_nodes" {
  count         = var.mongoDB_nodes_coount 
  ami           = var.mongoDB_ami 
  instance_type = var.mongoDB_instance_type
  subnet_id     = count.index % 2 == 0 ? var.subnet_ids[0] : var.subnet_ids[1]
  security_groups = [aws_security_group.mongodb_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "${var.environment}-mrama-mongoDB-Node-${count.index + 1}"
    Project = "mrama"
  }
}
