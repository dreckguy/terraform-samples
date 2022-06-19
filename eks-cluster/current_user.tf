data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}



output "caller_username" {
  value = local.current_user_username
}

locals {
  current_user_arn = data.aws_caller_identity.current.arn
  current_user_arn_parts = split("/",data.aws_caller_identity.current.arn)
  current_user_username = element(local.current_user_arn_parts,1)
}