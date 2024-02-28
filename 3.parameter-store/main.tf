resource "aws_ssm_parameter" "mrama-svc1-featureA" {
  name  = "/config/${var.environment}/mrama-svc1-featureA"
  type  = "String"
  value = var.mrama-svc1-featureA
}

resource "aws_ssm_parameter" "mrama-svc1-featureB" {
  name  = "/config/${var.environment}/mrama-svc1-featureB"
  type  = "String"
  value = var.mrama-svc1-featureA
}

resource "aws_ssm_parameter" "mongodb-connecting_string" {
  name  = "/config/${var.environment}/mongodb-connecting_string"
  type  = "String"
  value = var.mongodb-connecting_string
}

resource "aws_ssm_parameter" "postges-connection_string" {
  name  = "/config/${var.environment}/postges-connection_string"
  type  = "String"
  value = var.postges-connection_string
}
