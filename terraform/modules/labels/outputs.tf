
output "id" {
  value       = local.id
  description = "Disambiguated ID aka name"
}

output "tenant_ids" {
  value       = { for k, v in local.ids : k => v if k != "" }
  description = "Disambiguated IDs a.k.a. names for tenants"
}

output "name" {
  value       = local.attributes[""]["name"]
  description = "Normalized name"
}

output "environment" {
  value       = local.attributes[""]["stage"]
  description = "Normalized environment"
}

output "stage" {
  value       = local.attributes[""]["stage"]
  description = "Normalized stage"
}

output "layer" {
  value       = local.attributes[""]["layer"]
  description = "Normalized terraform layer"
}

output "project" {
  value       = local.attributes[""]["project"]
  description = "Normalized project"
}

output "delimiter" {
  value       = var.delimiter
  description = "Delimiter between `environment`, `project`, `name` and `attributes`"
}

output "resource_group" {
  value       = local.attributes[""]["resource_group"]
  description = "Resource group"
}

output "tags" {
  value       = local.tags
  description = "Normalized Tag map"
}

output "tenant_tags" {
  value       = { for k, v in local.tags_per_tenant : k => v if k != "" }
  description = "Normalized Tag map for tenants"
}

output "workspace_prefix" {
  value       = local.attributes[""]["workspace_prefix"]
  description = "Workspace name in non-default workspaces, '' in default"
}

output "resource" {
  value       = local.resource_name
  description = "Map of resource names (max character length 64) and tags"
}

output "tenant_resources" {
  value       = { for k, v in local.resource_names : k => v if k != "" }
  description = "Map of tenants and resource names (max character length is defined with the input variable `max_length`) and tags"
}

output "name_collisions" {
  value       = local.name_collisions
  description = "Map of name collisions detected after truncation (for testing/debugging)"
}
