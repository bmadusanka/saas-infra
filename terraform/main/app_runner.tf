resource "aws_apprunner_service" "consultation_app" {
  service_name      = "consultation-app-service"
  instance_role_arn = aws_iam_role.apprunner_instance_role.arn

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_service_role.arn
    }

    image_repository {
      image_identifier      = "${aws_ecr_repository.consultation_app.repository_url}:latest"
      image_repository_type = "ECR"

      image_configuration {
        port = "8000"

        runtime_environment_secrets = {
          CLERK_SECRET_KEY = aws_secretsmanager_secret.openai.arn
          CLERK_JWKS_URL   = aws_secretsmanager_secret.clerk_url.arn
          OPENAI_API_KEY   = aws_secretsmanager_secret.clerk_key.arn
        }
      }
    }

    auto_deployments_enabled = false
  }

  instance_configuration {
    cpu    = "0.25 vCPU"
    memory = "0.5 GB"
  }

  health_check_configuration {
    protocol            = "HTTP"
    path                = "/health"
    interval            = 20
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.consultation.arn
  tags = merge(
    module.labels.resource["consultation-app"]["tags"]
  )
}

resource "aws_apprunner_auto_scaling_configuration_version" "consultation" {
  auto_scaling_configuration_name = "consultation-app-scaling"

  min_size = 1
  max_size = 1
}
