<!-- BEGIN_TF_DOCS -->
<p align="center">                                                                                                                                            
                                                                                
  <img src="https://github.com/StratusGrid/terraform-readme-template/blob/main/header/stratusgrid-logo-smaller.jpg?raw=true" />
  <p align="center">                                                           
    <a href="https://stratusgrid.com/book-a-consultation">Contact Us</a> |                  
    <a href="https://stratusgrid.com/cloud-cost-optimization-dashboard">Stratusphere FinOps</a> |
    <a href="https://stratusgrid.com">StratusGrid Home</a> |
    <a href="https://stratusgrid.com/blog">Blog</a>
  </p>                    
</p>

 # terraform-github-repository-creation

 GitHub: [StratusGrid/terraform-github-repository-creation](https://github.com/StratusGrid/terraform-github-repository-creation)

 This module creates GitHub repositories with pre-configured workflow standards. It can use repository templates to provision a repository.

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
 ---
 ## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |
 
 ## Resources

| Name | Type |
|------|------|
| [github_branch_protection.this_main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_team_repository.this_terraform](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.this_terraform_admin](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |

 ## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create repositories | `bool` | `true` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | Owner of the GitHub repository | `string` | n/a | yes |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Boolean to set the repositories given as template or not | `bool` | `false` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | A map of Repository objects and their source template repos | <pre>map(object({<br>    repository_template             = optional(string, "")<br>    required_approving_review_count = optional(number, 2)<br>    visibility                      = optional(string, "private")<br>    required_linear_history         = optional(bool, false)<br>    archived                        = optional(bool, false)<br>  }))</pre> | n/a | yes |

 ## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repositories"></a> [github\_repositories](#output\_github\_repositories) | A map of the Github repositories. |

 ---

 <span style="color:red">Note:</span> Manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->