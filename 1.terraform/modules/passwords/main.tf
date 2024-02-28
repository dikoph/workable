resource "random_password" "postgres_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "postgres_password" {
  name        = "${var.environment}-mrama-postgres_passwd"
}

resource "aws_secretsmanager_secret_version" "postgres_password" {
  secret_id     = aws_secretsmanager_secret.postgres_password.id
  secret_string = "{\"password\": \"${random_password.postgres_password.result}\"}"
}



resource "random_password" "documentdb_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "documentdb_password" {
  name        = "${var.environment}-mrama-documentdb_passwd"
}

resource "aws_secretsmanager_secret_version" "documentdb_password" {
  secret_id     = aws_secretsmanager_secret.documentdb_password.id
  secret_string = "{\"password\": \"${random_password.documentdb_password.result}\"}"
}

