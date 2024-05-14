output "Github_action_Access_key_id" {
  value = aws_iam_access_key.github_action_key.id
}

output "Github_action_Access_key_secret" {
  value = aws_iam_access_key.github_action_key.encrypted_secret
}