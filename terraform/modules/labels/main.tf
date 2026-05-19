locals {
  max_tenant_length    = (var.max_length - var.max_length % 4) / 4
  max_workspace_length = (var.max_length - var.max_length % 3) / 3
  is_case_lower        = var.case == "lower"
  workspace            = terraform.workspace == "default" ? "" : terraform.workspace
  attributes = { for tenant in concat(var.tenants, [""]) : tenant => { for k, v in {
    workspace_prefix = replace(trimsuffix(substr(local.workspace, 0, local.max_workspace_length), var.delimiter), "-", var.delimiter)
    project          = replace(var.project, "-", var.delimiter)
    tenant           = replace(trimsuffix(substr(tenant, 0, local.max_tenant_length), var.delimiter), "-", var.delimiter)
    stage            = replace(var.stage, "-", var.delimiter)
    name             = var.name
    resource_group   = var.resource_group
    delimiter        = var.delimiter
    layer            = var.layer
  } : k => var.convert_case ? local.is_case_lower ? lower(format("%v", v)) : upper(format("%v", v)) : format("%v", v) } }


  delimiter = local.attributes[""]["delimiter"]
  suffix    = substr(strrev(local.delimiter), 0, 1)
  order     = length(var.order) == 0 ? ["workspace_prefix", "project", "tenant", "stage", "name", "resource_group"] : var.order
  ids       = { for k, v in local.attributes : k => trimsuffix(substr(join(local.delimiter, compact([for key in local.order : v[key]])), 0, var.max_length), local.suffix) }
  id        = local.ids[""]

  tags_per_tenant = { for tenant, attribute in local.attributes : tenant => { for k, v in merge(var.additional_tags,
    {
      Name               = local.ids[tenant]
      Stage              = var.stage
      Tenant             = tenant
      TerraformWorkspace = terraform.workspace
      PlatformLayer      = var.layer
      Project            = var.project
      Managed            = "Terraform"
      GitRepository      = var.git_repository
    },
  ) : length(split(" ", k)) > 1 ? replace(title(k), " ", "") : k => v if v != "" /* filter from tags if value is "" */ } }
  tags = local.tags_per_tenant[""]

  resource_names = { for tenant, v in local.ids : tenant => {
    for r in var.resources : r => { id = trimsuffix(substr(join(local.delimiter, compact([v, replace(local.is_case_lower ? lower(r) : upper(r), "-", var.delimiter)])), 0, var.max_length), local.suffix),
      tags = merge(
        local.tags_per_tenant[tenant],
        { "Name" = join(local.delimiter, compact([local.ids[tenant], replace(local.is_case_lower ? lower(r) : upper(r), "-", var.delimiter)])) }
      )
    }
  } }
  resource_name = local.resource_names[""]

  name_collisions = {
    for id, resources in {
      for r in var.resources : local.resource_name[r].id => r...
    } : id => resources if length(resources) > 1
  }
}

check "unique_resource_names" {
  assert {
    condition     = length(local.name_collisions) == 0
    error_message = <<-EOT
      Name collision detected! After truncation to ${var.max_length} characters, multiple resources have the same name:
      ${join("\n      ", [for id, resources in local.name_collisions : "Name '${id}' is used by: ${join(", ", resources)}"])}
      Please use shorter resource names to avoid collisions.
    EOT
  }
}
