# Sammy's Travels on DigitalOcean - Terraform

> _IMPORTANT:_ A note on secrets/tokens/apis and the `terraform.tfstate` file. Ensure that any files containing secrets/tokens/apis as well as the `terraform.tfstate` file are _NOT_ stored in version control.

## Terraform file structure

This terraform code is [structured](https://timothymamo.com/post/structure-iac/) in a way to follow a [layered platform](https://timothymamo.com/post/platform-setup/) design. In essence infrastructure is grouped according to lifecycle and deployed from each specific [environment folder](./envs/prd/) at different times (currently there is only one production environment) .

```bash
envs
├── <env_name>
├──── <layer>
├────── main.tf                       # Calls the needed modules and sets the appropriate variables
├────── backend.tf                    # Specifies where the tfstate file is stored
├────── terraform.tfvars.example      # Example tfvars file, copy and modify as specified
modules
├── <module_name>
├──── README.md
├──── main.tf                         # The base of the module code. This could be named differently.
├──── locals.tf                       # Define ‘local’ values. These can be defaults that should not be changed or that are composed from variables.
├──── data.tf                         # Define any data resources which you might need from previous layers.
├──── outputs.tf                      # Outputs required
├──── provider.tf                     # Sets up all the providers and requirements to run terraform
└──── variables.tf                    # Terraform variable definitions and requirements
```

I won't be going into the specifics of each and every file, but if you have any questions or comments do not hesitate to reach out.

This is where most of the magic will happen as all you need to do is configure your variables and run 3 _(2 if you're confident in what is happening)_ commands.

```bash
## From the root of the repository change directory to the terraform directory
## (from the packer directory  use ../terraform)
cd terraform

## Copy the example file to terraform.tfvars, modify it with your own variables and save
cp terraform.tfvars.example terraform.tfvars
```

A list of required variables, as well as optional variables with their default values, is documented below. Go through the list and modify the `terraform.tfvars` accordingly with your own values.

After creating the variables run the following commands to deploy the resources:

```bash
## Initialise terraform to download any plugin binaries needed
terraform init

## Create and show a plan of what will be created
## (skip if you want to apply immediately)
terraform plan

## Apply the changes specified by confirming at the prompt
## (--auto-approve if you're feeling adventures)
terraform apply
```

**_What's happening in the background_**

When you confirm the output of the `terraform apply` command (or if you were feeling adventures, after hitting return on the `terraform apply --auto-approve` command), terraform creates a dependency graph to determine in which order to create resources (if you really want to get into the specifics of it all the [Terraform internals documentation](https://developer.hashicorp.com/terraform/internals) is great, especially the [Resource Graph section](https://developer.hashicorp.com/terraform/internals/graph)).

### A note about securing the Droplet and Spaces

The Firewall opens Ports 80 and 443 for general web interaction and also Port 22 to be able to SSH into the Droplet. We highly suggest that you SSH into the Droplet by using an [ssh key](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/) and that you restrict the IPs that can SSH into it by setting the `ssh_ip_range` variable.

A policy for the Spaces bucket is created during the creation process. This policy can be restricted to only allow  access to the bucket via the Restricted IP, Droplet IP and IPs specified in `ssh_ip_range` (if populated) by setting the `spaces_restrict_ip` variable to `true` (default `false`). If you do set the `spaces_restrict_ip` variable to `true` be aware that you won't be able to access artifacts in the bucket via DigitalOcean's UI (If needed you can set the variable back to `false` and run `terraform apply` again).

### A note on destroying

Should you wish to destroy the resources created all you need to do is run the destroy command (makes sense) from within the appropriate directory.

```bash
## Destroy the resources specified by confirming at the prompt
## (as with apply you can --auto-approve if you're feeling adventures)
terraform destroy
```

If you have any artifacts stored in your Spaces bucket the terraform destroy command will partly fail warning that the bucket cannot be destroyed. To destroy it you'll have to first remove all artifacts within the bucket and re-run `terraform destroy`.

## Terraform documentation

- Providers, Inputs and Outputs will be automatically documented using pre-commit hooks in the `README.md` file
  - To automatically create the documentation you need to install the hooks as described below
- The subdirectory has a `terraform.tfvars.example` file holding example values for variables required to implement the infrastructure.

### Hooks

Install `pre-commit` and `terraform-docs` (on MacOS, Homebrew has formulae for both).
Then run the `pre-commit install` command to install the pre-commit hooks specified.
