resource "aws_secretsmanager_secret" "openai" {
  name = "openai-api-key"
}

resource "aws_secretsmanager_secret" "clerk_url" {
  name = "clerk-jwks-url"
}

resource "aws_secretsmanager_secret" "clerk_key" {
  name = "clerk-secret-key"
}

resource "aws_secretsmanager_secret_version" "openai" {
  secret_id     = aws_secretsmanager_secret.openai.id
  secret_string = var.OPENAI_API_KEY
}

resource "aws_secretsmanager_secret_version" "clerk_url" {
  secret_id     = aws_secretsmanager_secret.clerk_url.id
  secret_string = var.CLERK_JWKS_URL
}

resource "aws_secretsmanager_secret_version" "clerk_key" {
  secret_id     = aws_secretsmanager_secret.clerk_key.id
  secret_string = var.CLERK_SECRET_KEY
}
