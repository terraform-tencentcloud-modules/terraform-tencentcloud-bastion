# Bastion host with public dns

A  example of define a generic Bastion host and resolve hosts using the public dns domain name

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
