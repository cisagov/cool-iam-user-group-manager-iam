# cool-iam-user-group-manager-iam #

[![GitHub Build Status](https://github.com/cisagov/cool-iam-user-group-manager-iam/workflows/build/badge.svg)](https://github.com/cisagov/cool-iam-user-group-manager-iam/actions)

This is a Terraform deployment for creating an IAM group (with an appropriate
IAM policy) for users who are allowed to manage (create, update, delete) IAM
users and groups in the COOL, and assigning users to that group.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [backend.tf](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [backend.tf](backend.tf)).
- Access to all of the Terraform remote states specified in
  [remote_states.tf](remote_states.tf).
- User accounts for all users must have been created previously.  We
  recommend using the
  [`cisagov/cool-users-non-admin`](https://github.com/cisagov/cool-users-non-admin)
  repository to create users.

## Usage ##

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
  variables (see [Inputs](#inputs) below for details):

  ```hcl
  users = [
    "firstname1.lastname1",
    "firstname2.lastname2"
  ]
  ```

1. Run the command `terraform init`.
1. Run the command `terraform apply -var-file=<workspace_name>.tfvars`.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |
| aws.users | ~> 4.9 |
| terraform | n/a |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_group.iam_user_group_managers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.iam_manager_login_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.iam_manager_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.iam_manager_login_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam_manager_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.iam_user_group_managers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.iam_manager_login_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_manager_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.audit](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.images](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.logarchive](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.master](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sharedservices](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.terraform](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.users](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| iam\_manager\_login\_mfa\_policy\_description | The description to associate with the IAM policy in the Users account that allows the IAM managers group to manage login profiles and MFA devices for IAM users. | `string` | `"Allows the IAM managers group to manage login profiles and MFA devices for IAM users."` | no |
| iam\_manager\_login\_mfa\_policy\_name | The name of the IAM policy in the Users account that allows the IAM managers group to manage login profiles and MFA devices for IAM users. | `string` | `"ManageLoginProfileAndMFA"` | no |
| iam\_manager\_roles\_policy\_description | The description to associate with the IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups. | `string` | `"Allows the IAM managers group to assume all roles needed in order to manage IAM users and groups."` | no |
| iam\_manager\_roles\_policy\_name | The name of the IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups. | `string` | `"AssumeRolesToManageIAMUsersAndGroups"` | no |
| iam\_managers\_group\_name | The name of the IAM group whose members are allowed to manage IAM users and groups. | `string` | `"iam_user_group_managers"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| users | A list containing the usernames of users that exist in the Users account who are allowed to manage IAM users and groups.  Example: [ "firstname1.lastname1", "firstname2.lastname2" ]. | `list(string)` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| iam\_manager\_login\_mfa\_policy | The IAM policy in the Users account that allows the IAM managers group to manage login profiles and MFA devices for IAM users. |
| iam\_manager\_roles\_policy | The IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups. |
| iam\_managers\_group | The IAM group whose members are allowed to manage IAM users and groups. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
