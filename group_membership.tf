# Put IAM user/group manager users in the appropriate group.
resource "aws_iam_user_group_membership" "iam_user_group_managers" {
  provider = aws.users
  for_each = toset(var.users)

  user = each.key

  groups = [
    aws_iam_group.iam_user_group_managers.name
  ]
}
