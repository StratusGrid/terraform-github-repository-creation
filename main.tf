locals {
  repositories = defaults(var.repositories, {
    repository_template             = ""
    required_approving_review_count = 2
    visibility                      = "private"
  })
}

resource "github_repository" "this" {
  for_each               = var.create ? local.repositories : {}
  name                   = each.key
  is_template            = var.is_template
  visibility             = local.repositories[each.key].visibility
  has_downloads          = true
  has_issues             = true
  has_projects           = true
  has_wiki               = false
  vulnerability_alerts   = true
  delete_branch_on_merge = true
  allow_merge_commit     = false

  dynamic "template" {
    for_each = local.repositories[each.key].repository_template == "" ? [] : [1]
    content {
      owner      = var.github_owner
      repository = local.repositories[each.key].repository_template
    }
  }

  lifecycle {
    ignore_changes = [
      description,
      template
    ]
    prevent_destroy = true
  }
}

#TODO - For each the following github team pieces and pass in a map to build these
data "github_team" "terraformers" {
  slug = "terraformers"
}

data "github_team" "terraform_admins" {
  slug = "terraform-admins"
}

resource "github_team_repository" "this_terraform" {
  for_each   = var.create ? github_repository.this : {}
  team_id    = data.github_team.terraformers.id
  repository = github_repository.this[each.key].name
  permission = "maintain"
}

resource "github_team_repository" "this_terraform_admin" {
  for_each   = var.create ? github_repository.this : {}
  team_id    = data.github_team.terraform_admins.id
  repository = github_repository.this[each.key].name
  permission = "admin"
}

resource "github_branch_protection" "this_main" {
  for_each       = var.create ? github_repository.this : {}
  repository_id  = github_repository.this[each.key].name
  pattern        = "main"
  enforce_admins = true


  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = local.repositories[each.key].required_approving_review_count
  }
}
