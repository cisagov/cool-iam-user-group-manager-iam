output "iam_managers_group" {
  value       = aws_iam_group.iam_user_group_managers
  description = "The IAM group whose members are allowed to manage IAM users and groups."
}

output "iam_managers_policy" {
  value       = aws_iam_policy.iam_managers
  description = "The IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups."
}
