terraform {
  required_version = ">= 1.6.0"
  cloud {
    organization = "diegokc"
    workspaces {
      name = "netlify-hcp-terraform"
    }
  }
  required_providers {
    netlify = {
      source  = "AegirHealth/netlify"
      version = ">= 0.1.6"
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
