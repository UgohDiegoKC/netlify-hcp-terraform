terraform {
  required_version = ">= 1.6.0"
  cloud {
    organization = var.tfc_organization
    workspaces {
      name = var.tfc_workspace
    }
  }
  required_providers {
    netlify = {
      source  = "netlify/netlify"
      version = ">= 0.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
    # Optional: uncomment if you want Terraform to also add the deploy key to your GitHub repo
    # github = {
    #   source  = "integrations/github"
    #   version = ">= 6.0.0"
    # }
  }
}
