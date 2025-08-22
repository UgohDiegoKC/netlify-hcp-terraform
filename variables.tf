variable "tfc_organization" {
  description = "HCP Terraform organization name"
  type        = string
  default     = "diegokc"
}

variable "tfc_workspace" {
  description = "HCP Terraform workspace name"
  type        = string
  default     = "netlify-hcp-terraform"
}

variable "project_name" {
  description = "Logical name prefix for all resources"
  type        = string
  default     = "hug-netlify-demo"
}

variable "site_name" {
  description = "Base subdomain for the Netlify site (suffix is auto-appended for uniqueness)"
  type        = string
  default     = "hello-hug"
}

# If you want Netlify to build from a Git repo, set these.
variable "git_provider" {
  description = "VCS provider for Netlify (one of: github, gitlab, bitbucket). Leave empty to deploy without a repo."
  type        = string
  default     = "github"
}

variable "repo_path" {
  description = "owner/repo for the site source (e.g., youruser/hug-netlify-demo)"
  type        = string
  default     = ""
}

variable "repo_branch" {
  description = "Branch to build"
  type        = string
  default     = "main"
}

# Optional: only needed if you want Terraform to also register the deploy key into GitHub automatically.
# variable "github_owner" {
#   description = "GitHub org/user that owns the repo (only when using the GitHub provider to upload the deploy key)"
#   type        = string
#   default     = ""
# }
