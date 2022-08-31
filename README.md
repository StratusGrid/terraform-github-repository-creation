<!-- BEGIN_TF_DOCS -->
# terraform-github-repository-creation

GitHub: [StratusGrid/terraform-github-repository-creation](https://github.com/StratusGrid/terraform-github-repository-creation)

This Repo is to create GitHub repositories within StratusGrid organization with all of our workflow standards. It can use repository templates to provision a repository.

## Example

```hcl
module "terraform-github-repository-creation" {
  source   = "github.com/StratusGrid/terraform-github-repository-creation"
  github_owner = "StratusGrid"
  repositories = {
      my-awesome-terraform-module = {
        repository_template = "terraform-automation-module-starter"
        required_approving_review_count = 2
      }
      my-awesome-terraform-project = {
        repository_template = "terraform-automation-project-starter"
      }
}
}
```

## StratusGrid Standards we assume

- This repo is designed to be built upon the [StratusGrid Terraform Automation](https://github.com/StratusGrid/terraform-automation)
- All resource names and name tags shall use `_` and not `-`s
- StratusGrid generally follows the TerraForm standards outlined [here](https://www.terraform-best-practices.com/naming)

## Repo Knowledge

This repo has several base requirements
- The following packages are installed via brew: `tflint`, `terraform-docs`, `gitleaks`, `pre-commit`, `go`
- Install `bash` through Brew for Bash 5.0, otherwise it will fail with the error that looks like `declare: -g: invalid option`
- If you need more tflint plugins, please edit the `.tflint.hcl` file with the instructions from [here](https://github.com/terraform-linters/tflint)
- It's highly recommend that you follow the Git Pre-Commit Instructions below, these will run in GitHub though they should be ran locally to reduce issues
- By default Terraform docs will always run so our auto generated docs are always up to date
- This repo has been tested with [awsume](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/1564966913/Awsume)
- The Terraform module standard is to place everything in the `main.tf` file, and this works well for small modules. Though StratusGrid suggests breaking it out into multiple files if the module is larger or touches many resources such as data blocks.
- StratusGrid requires the tag logic be used and every resource within the module be tagged with `local.tags`

### TFSec

See the pre-commit tfsec documentation [here](https://github.com/antonbabenko/pre-commit-terraform#terraform_tfsec), this includes on how to bypass warnings

## Apply this template via Terraform

### Before this is applied, you need to configure the git hook on your local machine
```bash
#Verify you have bash5
brew install bash

# Test your pre-commit hooks - This will force them to run on all files
pre-commit run --all-files

# Add your pre-commit hooks forever
pre-commit install
```

## Documentation

This repo is self documenting via Terraform Docs, please see the note at the bottom.

### `LICENSE`
This is the standard Apache 2.0 License as defined [here](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/2121728017/StratusGrid+Terraform+Module+Requirements).

### `outputs.tf`
The StratusGrid standard for Terraform Outputs.

### `README.md`
It's this file! I'm always updated via TF Docs!

### `variables.tf`
All variables related to this repo for all facets.
One day this should be broken up into each file, maybe maybe not.

### `versions.tf`
This file contains the required providers and their versions. Providers need to be specified otherwise provider overrides can not be done.

## Documentation of Misc Config Files

This section is supposed to outline what the misc configuration files do and what is there purpose

### `.config/.terraform-docs.yml`
This file auto generates your `README.md` file.

### `.config/terrascan.yaml`
This file has all of the configuration options required for Terrascan, this is where you would skip rules to.

### `.github/sync-repo-settings.yaml`
This file is our standard for how GitHub branch protection rules should be setup.

### `.github/workflows/pre-commit.yml`
This file contains the instructions for Github workflows, in specific this file run pre-commit and will allow the PR to pass or fail. This is a safety check and extras for if pre-commit isn't run locally.

### `.vscode/settings.json`
This file is a vscode workspace settings file.

### `examples/*`
The files in here are used by `.config/terraform-docs.yml` for generating the `README.md`. All files must end in `.tfnot` so Terraform validate doesn't trip on them since they're purely example files.

### `.gitignore`
This is your gitignore, and contains a slew of default standards.

### `.pre-commit-config.yaml`
This file is the GIT pre-commit file and contains all of it's configuration options

### `.prettierignore`
This file is the ignore file for the prettier pre-commit actions. Specific files like our SOPS config files have to be ignored.

### `.tflint.hcl`
This file contains the plugin data for TFLint to run.

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 4.5.1 |

## Resources

| Name | Type |
|------|------|
| [github_branch_protection.this_main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_team_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create repositories | `bool` | `true` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | Owner of the GitHub repository | `string` | n/a | yes |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Boolean to set the repositories given as template or not | `bool` | `false` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | A map of Repository objects and their source template repos | <pre>map(object({<br>    repository_template             = optional(string)<br>    required_approving_review_count = optional(number)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repositories"></a> [github\_repositories](#output\_github\_repositories) | A map of the Github repositories. |

---

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml`
<!-- END_TF_DOCS -->