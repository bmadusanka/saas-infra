variable "project" {
  type        = string
  default     = ""
  description = "Project, which could be your organization name or abbreviation"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prd', 'int', 'dev'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. `app` or `jenkins`"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between attributes i.e. `workspace`, `project`, `stage` and `name`"
}

variable "resource_group" {
  type        = string
  default     = ""
  description = "Main identifier of the resource group for which the module will generate labels (e.g. 'rds' or 'alb')"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "convert_case" {
  type        = bool
  default     = true
  description = "Convert fields to different case default: lower"
}

variable "case" {
  type        = string
  default     = "lower"
  description = "Which case to use in: can be lower or upper"
  validation {
    condition     = var.case == "lower" || var.case == "upper"
    error_message = "The variable must be either 'lower' or 'upper'."
  }
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "resources" {
  description = "Additional labels that need to be created under the resource group (e.g. 'sg', 'kms')"
  type        = list(string)
  default     = []
}

variable "max_length" {
  type        = number
  default     = 64
  description = "Maximum length of ID"
}

variable "tenants" {
  description = "Optional attribute used in the identifier and resource tags"
  type        = list(string)
  default     = []
}

variable "layer" {
  type        = string
  default     = ""
  description = "Terraform layer e.g. base"
}

variable "order" {
  default     = []
  type        = list(string)
  description = "Order of label components"
}

variable "git_repository" {
  type        = string
  description = "Repository where the infrastructure was deployed from."
}
