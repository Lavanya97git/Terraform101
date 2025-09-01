output "created_repo_names" {
  description = "List of GitHub repository names created"
  value       = [for repo in github_repository.example : repo.name]
}