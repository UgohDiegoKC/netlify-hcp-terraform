# Random suffix so the Netlify subdomain is unique on every deploy
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

# Netlify provider. Do NOT hardcode the token here.
# Authenticate with an environment variable NETLIFY_TOKEN or set it as a sensitive HCP Terraform variable.
provider "netlify" {
  # token is read from the NETLIFY_TOKEN env var when omitted
}

# Optional: configure the GitHub provider to auto-add the deploy key into your repository.
# provider "github" {
#   owner = var.github_owner
#   # token read from GITHUB_TOKEN env var or HCP Terraform sensitive variable
# }

# A deploy key that Netlify will use to read your repo (only needed when linking a repo)
resource "netlify_deploy_key" "this" {}

# Primary Netlify site. If you don't want to build from a repo, you can omit the repo {} block
# and just use drag-and-drop or the Netlify CLI for manual uploads later.
resource "netlify_site" "this" {
  name = "${var.site_name}-${random_string.suffix.result}"

  # Comment this block out if you plan to deploy without a repo.
  dynamic "repo" {
    for_each = length(var.repo_path) > 0 ? [1] : []
    content {
      provider      = var.git_provider
      repo_path     = var.repo_path
      repo_branch   = var.repo_branch
      deploy_key_id = netlify_deploy_key.this.id
      dir           = "site"
      # command can be empty for plain HTML; set if using a static site generator
      command       = ""
    }
  }
}

# If you enabled the GitHub provider above, this will attach the deploy key to your repo automatically.
# resource "github_repository_deploy_key" "netlify" {
#   title      = "netlify-${var.site_name}"
#   repository = split("/", var.repo_path)[1]
#   key        = netlify_deploy_key.this.public_key
#   read_only  = true
# }

# Optionally, set environment variables in Netlify via Terraform
resource "netlify_environment_variable" "example" {
  site_id = netlify_site.this.id
  key     = "APP_GREETING"
  values  = ["Hello from Terraform!"]
}

# Helpful outputs
output "netlify_site_name" {
  description = "Netlify site short name (subdomain)"
  value       = netlify_site.this.name
}

output "netlify_site_id" {
  description = "Netlify site ID"
  value       = netlify_site.this.id
}

# Most Netlify sites are reachable at https://<name>.netlify.app
output "netlify_site_url_guess" {
  description = "Convenience guess of your site URL (works for default Netlify subdomains)"
  value       = "https://${netlify_site.this.name}.netlify.app"
}
