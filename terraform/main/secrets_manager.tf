resource "aws_secretsmanager_secret" "openai" {
  name = "openai-api-key"
}

resource "aws_secretsmanager_secret" "clerk_url" {
  name = "clerk-jwks-url"
}

resource "aws_secretsmanager_secret" "clerk_key" {
  name = "clerk-secret-key"
}