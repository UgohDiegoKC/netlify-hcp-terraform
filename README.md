# Netlify Site + HCP Terraform Remote State (Starter)

This repository is a **ready-to-run solution** for the challenge: deploy a static site to **Netlify** with state stored remotely in **HCP Terraform**.

> ✅ You get: Terraform config, a minimal static site, and a README with exact steps.

## What this does

- Provisions a **Netlify site** with a unique subdomain using the official Terraform provider.
- Stores Terraform state in **HCP Terraform** (via the `cloud` block).
- (Optional) Links a Git repo for CI builds using a Netlify **deploy key**.
- Exposes outputs, including the guessed **live URL**.
- Demonstrates managing **Netlify environment variables** by Terraform.

---

## Prerequisites

- Terraform **1.6+**
- A free **Netlify** account and a **Personal Access Token** (PAT)
- A free **HCP Terraform** (Terraform Cloud) account
- (Optional) A GitHub repo if you want Netlify to build from Git

---

## HCP Terraform (Remote State)

1. In HCP Terraform, create an **organization** and a **workspace** (execution mode `Local` or `Agent` is fine for testing; `Remote` also works).
2. Set **workspace variables**:
   - **Environment variable**: `NETLIFY_TOKEN` = your Netlify PAT (**sensitive**)
   - (Optional) **Environment variable**: `GITHUB_TOKEN` if you enable the GitHub provider block
   - **Terraform variables** (if you want custom names):
     - `tfc_organization` = your org name
     - `tfc_workspace`    = your workspace name
     - `site_name`        = preferred site prefix (e.g., `hello-hug`)
     - `repo_path`        = `youruser/yourrepo` (leave empty to skip linking a repo)
     - `repo_branch`      = `main` (or your default branch)

> The Terraform `cloud` block in `providers.tf` points Terraform at your org/workspace so state is stored remotely by default.

---

## Local Run (quickest path)

```bash
# 1) Export your Netlify token locally (or set it in HCP Terraform variables)
export NETLIFY_TOKEN=xxxxxx

# 2) Initialize and apply
terraform init
terraform plan
terraform apply -auto-approve
```

When apply completes, note these outputs:

- `netlify_site_name`
- `netlify_site_url_guess` (usually works out of the box: `https://<name>.netlify.app`)

> If you set `repo_path`, Netlify will try to build from your repo's `site/` directory. If you left it empty, open the Netlify UI to upload the `site/` folder or use `netlify deploy` via the CLI.

---

## Minimal Static Site

A single page lives in `site/index.html`. Edit it freely. If you use a static site generator, set the `repo.command` and `repo.dir` accordingly in `main.tf`.

---

## Keep Secrets Out of the Repo

- Never commit tokens. We rely on **environment variables** / **HCP workspace variables**.
- `.gitignore` excludes local state and editor files.

---

## Clean Up

```bash
terraform destroy
```

---

## Troubleshooting

- **Provider not found or outdated**: run `terraform init -upgrade`.
- **No site created**: Ensure your `NETLIFY_TOKEN` is valid and has API access.
- **Repo linking fails**: Provide `repo_path` and ensure the deploy key is added to your repo (either via the optional GitHub resource or manually in repo settings).
- **Live URL**: Most sites are served from `https://<site-name>.netlify.app`. The exact attribute may vary; check the Netlify UI if needed.

---

## Attribution

- Netlify Terraform provider usage and PAT auth are described in the provider README (token via `NETLIFY_TOKEN` env var).
- Challenge date: 2025-08-22
