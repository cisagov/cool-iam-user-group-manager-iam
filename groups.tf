# An IAM group for IAM user/group managers.
resource "aws_iam_group" "iam_user_group_managers" {
  provider = aws.users

  name = var.iam_managers_group_name
}

# Attach the policy that allows group members to assume roles needed in order
# to manage IAM users and groups.
resource "aws_iam_group_policy_attachment" "iam_manager_roles" {
  provider = aws.users

  group      = aws_iam_group.iam_user_group_managers.name
  policy_arn = aws_iam_policy.iam_manager_roles.arn
}

# Attach the policy that allows group members to manage login profiles and MFA
# devices for IAM users.
resource "aws_iam_group_policy_attachment" "iam_manager_login_mfa" {
  provider = aws.users

  group      = aws_iam_group.iam_user_group_managers.name
  policy_arn = aws_iam_policy.iam_manager_login_mfa.arn
}
