

module "labels" {
  source         = "../modules/labels/"
  git_repository = var.git_repository
  project        = var.project
  stage          = var.stage
  layer          = var.stage
  resources = [
    "consultation-app",
    "apprunner-ecr-access-role"
  ]
}
