variable "git_repository" {
  type        = string
  description = "Repository where the infrastructure was deployed from."
}

variable "stage" {
  description = "Specify to which project this resource belongs, no default value to allow proper validation of project setup"
  type        = string
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