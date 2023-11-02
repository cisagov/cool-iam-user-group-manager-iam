# An IAM group for IAM user/group managers.
resource "aws_iam_group" "iam_user_group_managers" {
  provider = aws.users

  name = var.iam_managers_group_name
}

# Attach the policy that allows assumption of the IAM user/group management role.
resource "aws_iam_group_policy_attachment" "iam_user_group_managers" {
  provider = aws.users

  group      = aws_iam_group.iam_user_group_managers.name
  policy_arn = aws_iam_policy.iam_managers.arn
}
