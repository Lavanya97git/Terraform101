terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
  }
}

provider "github" {
  # Configuration options
  token = var.git_token
}
resource "github_repository" "example" {
  count = var.repo_count
  name        = "example-${count.index}"
  description = "My awesome codebase"

  visibility = "public"
}