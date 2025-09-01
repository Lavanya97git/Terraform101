variable "git_token" {
    type = string
    description = "GitHub Token"
    sensitive = true
}
variable "repo_count" {
    type = string
    default = "2"
    description = "Number of repos to create"
}