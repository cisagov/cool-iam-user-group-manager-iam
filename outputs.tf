output "iam_manager_login_mfa_policy" {
  description = "The IAM policy in the Users account that allows the IAM managers group to manage login profiles and MFA devices for IAM users."
  value       = aws_iam_policy.iam_manager_login_mfa
}

output "iam_manager_roles_policy" {
  description = "The IAM policy in the Users account that allows the IAM managers group to assume all roles needed in order to manage IAM users and groups."
  value       = aws_iam_policy.iam_manager_roles
}

output "iam_managers_group" {
  description = "The IAM group whose members are allowed to manage IAM users and groups."
  value       = aws_iam_group.iam_user_group_managers
}
