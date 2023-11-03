# The policy document that allows assumption of all roles needed in order to
# manage IAM users and groups.
data "aws_iam_policy_document" "iam_manager_roles" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    effect = "Allow"

    resources = local.required_roles

    sid = "AllowRequiredRoles"
  }
}

# The policy that allows assumption of all roles needed in order to manage
# IAM users and groups.
resource "aws_iam_policy" "iam_manager_roles" {
  provider = aws.users

  description = var.iam_manager_roles_policy_description
  name        = var.iam_manager_roles_policy_name
  policy      = data.aws_iam_policy_document.iam_manager_roles.json
}

# The policy document with IAM-specific permissions necessary to:
# - Enable/disable console access for IAM users
# - Create/delete virtual MFA devices for IAM users
data "aws_iam_policy_document" "iam_manager_login_mfa" {
  statement {
    actions = [
      "iam:CreateLoginProfile",
      "iam:CreateVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:DeleteLoginProfile",
      "iam:DeleteVirtualMFADevice",
      "iam:GetLoginProfile",
      "iam:GetMFADevice",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:ListGroupsForUser",
      "iam:ListMFADevices",
      "iam:ListMFADeviceTags",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:TagMFADevice",
      "iam:UntagMFADevice",
      "iam:UpdateLoginProfile",
    ]

    effect = "Allow"

    resources = ["*"]

    sid = "ManageLoginProfileAndMFA"
  }
}

# The policy that grants IAM-specific permissions necessary to:
# - Enable/disable console access for IAM users
# - Create/delete virtual MFA devices for IAM users
resource "aws_iam_policy" "iam_manager_login_mfa" {
  provider = aws.users

  description = var.iam_manager_login_mfa_policy_description
  name        = var.iam_manager_login_mfa_policy_name
  policy      = data.aws_iam_policy_document.iam_manager_login_mfa.json
}
