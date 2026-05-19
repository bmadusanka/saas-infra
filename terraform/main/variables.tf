variable "git_repository" {
  type        = string
  default     = "saas-infra"
  description = "Repository where the infrastructure was deployed from."
}

variable "stage" {
  description = "Specify to which project this resource belongs, no default value to allow proper validation of project setup"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "Default Region for Cloud Platform"
  default     = "eu-central-1"
  type        = string
}

variable "project" {
  description = "Specify to which project this resource belongs"
  default     = "medica-ai"
  type        = string
}

variable "CLERK_SECRET_KEY" {
  description = "Specify clerk secret key to use"
  type        = string
}

variable "CLERK_JWKS_URL" {
  description = "Specify clerk JWKS Url to use"
  type        = string
}

variable "OPENAI_API_KEY" {
  description = "Specify Open API key to use"
  type        = string
}