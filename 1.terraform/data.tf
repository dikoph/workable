data "aws_secretsmanager_secret" "postgres_password_secret" {
  name = "${var.environment}-mrama-postgres_passwd"
  depends_on = [module.passwords]
}

data "aws_secretsmanager_secret_version" "postgres_password_secret" {
  secret_id = data.aws_secretsmanager_secret.postgres_password_secret.id
  depends_on = [module.passwords]
}


data "aws_secretsmanager_secret" "documentdb_password_secret" {
  name = "${var.environment}-mrama-postgres_passwd"
  depends_on = [module.passwords]
}

data "aws_secretsmanager_secret_version" "documentdb_password_secret" {
  secret_id = data.aws_secretsmanager_secret.documentdb_password_secret.id
  depends_on = [module.passwords]
}

