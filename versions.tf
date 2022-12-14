terraform {
  required_version = ">= 1.2.9"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.5.1"
    }
  }
}
