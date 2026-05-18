

module "labels" {
  source         = "../modules/labels/"
  git_repository = var.git_repository
  project        = var.project
  stage          = var.stage
  layer          = var.stage
  project_id     = var.project_id
  kst            = var.tag_KST
  wa_number      = var.wa_number
  resources = [
    "consultation-app"
  ]
}