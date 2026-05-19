terraform {
  backend "s3" {
    bucket       = "mlops-labs-terraform-state"
    key          = "udemy/mlops/terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
    encrypt      = true
  }
}
