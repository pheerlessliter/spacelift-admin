data "aws_caller_identity" "current" {}

locals {
  role_name = "spacelift-integration"
  role_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.role_name}"
}

resource "spacelift_aws_integration" "aws" {
  name                           = local.role_name
  role_arn                       = local.role_arn
  generate_credentials_in_worker = false
}

data "spacelift_aws_integration_attachment_external_id" "spacelift_testing" {
  integration_id = spacelift_aws_integration.aws.id
  stack_id       = spacelift_stack.spacelift_testing.id
  read           = true
  write          = true
}

resource "aws_iam_role" "spacelift" {
  name = local.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      jsondecode(data.spacelift_aws_integration_attachment_external_id.spacelift_testing.assume_role_policy_statement),
    ]
  })
}

resource "aws_iam_role_policy_attachment" "spacelift" {
  role       = aws_iam_role.spacelift.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
