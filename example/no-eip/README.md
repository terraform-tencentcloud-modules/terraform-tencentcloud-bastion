# Bastion host without eip

A  example of define a generic Bastion host without eip

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform  plan  -var-file=test.tfvars
$ terraform apply  -var-file=test.tfvars
```

Note that this example may create resources which cost money. Run `terraform destroy -var-file=test.tfvars` when you don't need these
 resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
