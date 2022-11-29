variable "repositories" {
  description = "A map of Repository objects and their source template repos"
  type = map(object({
    repository_template             = optional(string)
    required_approving_review_count = optional(number)
    visibility                      = optional(string)
  }))
}

variable "github_owner" {
  description = "Owner of the GitHub repository"
  type        = string
}

variable "is_template" {
  description = "Boolean to set the repositories given as template or not"
  type        = bool
  default     = false
}

variable "create" {
  description = "Whether to create repositories"
  type        = bool
  default     = true
}

variable "required_linear_history" {
  description = "If it needs to use the linear history feature"
  type        = bool
  default     = true
}
