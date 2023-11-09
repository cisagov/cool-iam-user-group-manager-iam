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

  # Assumption of the following roles are required to successfully manage IAM
  # users and groups.  The sources for this list of roles are the following
  # providers, whose respective repositories are used to manage IAM users and
  # groups:
  # https://github.com/cisagov/cool-admin-provisioner-iam/blob/develop/providers.tf
  # https://github.com/cisagov/cool-assessment-provisioner-iam/blob/develop/providers.tf
  # https://github.com/cisagov/cool-auditor-iam/blob/develop/providers.tf
  # https://github.com/cisagov/cool-ses-send-email-iam/blob/develop/providers.tf
  # https://github.com/cisagov/cool-users-non-admin/blob/develop/providers.tf
  #
  # Related issue: "Use more targeted permissions to manage user roles"
  # https://github.com/cisagov/cool-system-internal/issues/137
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
