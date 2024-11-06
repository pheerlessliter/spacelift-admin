data "aws_caller_identity" "current" {}

locals {
  role_name = "spacelift-integration"
  role_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.role_name}"
}

resource "spacelift_aws_integration" "aws" {
  name = local.role_name

  # We need to set the ARN manually rather than referencing the role to avoid a circular dependency
  role_arn                       = local.role_arn
  generate_credentials_in_worker = false
}

resource "aws_iam_role" "spacelift" {
  name = local.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      jsondecode(data.spacelift_aws_integration_attachment_external_id.my_stack.assume_role_policy_statement),
      jsondecode(data.spacelift_aws_integration_attachment_external_id.my_module.assume_role_policy_statement),
    ]
  })
}
