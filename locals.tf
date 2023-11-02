# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which Terraform is
# authorized.  This is used to calculate the session names for assumed roles.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "default" {}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Extract the user name of the current caller for use
  # as assume role session names.
  caller_user_name = split("/", data.aws_caller_identity.default.arn)[1]

  # Assumption of the following roles is required to successfully manage IAM
  # users and groups.
  required_roles = [
    data.terraform_remote_state.audit.outputs.provisionaccount_role.arn,
    data.terraform_remote_state.dns.outputs.provisionaccount_role.arn,
    data.terraform_remote_state.images.outputs.provisionaccount_role.arn,
    data.terraform_remote_state.logarchive.outputs.provisionaccount_role.arn,
    data.terraform_remote_state.master.outputs.organizationsreadonly_role.arn,
    data.terraform_remote_state.sharedservices.outputs.provisionaccount_role.arn,
    data.terraform_remote_state.terraform.outputs.provisionaccount_role.arn,
    data.terraform_remote_state.users.outputs.provisionaccount_role.arn,
  ]
}
