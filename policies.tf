# The policy document that allows assumption of all roles needed in order to
# manage IAM users and groups.
data "aws_iam_policy_document" "iam_managers" {
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
resource "aws_iam_policy" "iam_managers" {
  provider = aws.users

  description = var.iam_managers_policy_description
  name        = var.iam_managers_policy_name
  policy      = data.aws_iam_policy_document.iam_managers.json
}
