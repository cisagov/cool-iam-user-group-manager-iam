# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

variable "users" {
  description = "A list containing the usernames of users that exist in the Users account who are allowed to manage IAM users and groups.  Example: [ \"firstname1.lastname1\", \"firstname2.lastname2\" ]."
  nullable    = false
  type        = list(string)
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  nullable    = false
  type        = string
}

variable "iam_managers_group_name" {
  default     = "iam_user_group_managers"
  description = "The name of the IAM group whose members are allowed to manage IAM users and groups."
  nullable    = false
  type        = string
}

variable "iam_manager_login_mfa_policy_description" {
  default     = "Allows the IAM managers group to manage login profiles, access keys, and MFA devices for IAM users."
  description = "The description to associate with the IAM policy in the Users account that allows the IAM managers group to manage login profiles, access keys, and MFA devices for IAM users."
  nullable    = false
  type        = string
}

variable "iam_manager_login_mfa_policy_name" {
  default     = "ManageLoginProfileAccessKeysAndMFA"
  description = "The name of the IAM policy in the Users account that allows the IAM managers group to manage login profiles, access keys, and MFA devices for IAM users."
  nullable    = false
  type        = string
}

variable "iam_manager_roles_policy_description" {
  default     = "Allows the IAM managers group to assume all roles needed in order to manage IAM users and groups."
  description = "The description to associate with the IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups."
  nullable    = false
  type        = string
}

variable "iam_manager_roles_policy_name" {
  default     = "AssumeRolesToManageIAMUsersAndGroups"
  description = "The name of the IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups."
  nullable    = false
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  nullable    = false
  type        = map(string)
}
