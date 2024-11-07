resource "spacelift_stack" "spacelift_testing" {
  name                             = "Proof of Concept Infrastructure"
  branch                           = "main"
  repository                       = "spacelift-testing"
  description                      = "Test job for determining current state and usefulness of Spacelift.io"
  space_id                         = spacelift_space.poc.id
  labels                           = ["autoattach:pr_feedback"]
  administrative                   = false
  manage_state                     = true
  autodeploy                       = true
  enable_local_preview             = true
  enable_well_known_secret_masking = true
  github_action_deploy             = true
  github_enterprise {
    namespace = "pheerlessliter"
  }
  terragrunt {
    terraform_version      = "1.5.7"
    terragrunt_version     = "0.68.7"
    use_run_all            = true
    use_smart_sanitization = true
  }
}

resource "spacelift_aws_integration_attachment" "spacelift_testing" {
  integration_id = spacelift_aws_integration.aws.id
  stack_id       = spacelift_stack.spacelift_testing.id
  read           = true
  write          = true

  depends_on = [
    aws_iam_role.spacelift
  ]
}

resource "spacelift_stack_activator" "spacelift_testing" {
  enabled  = true
  stack_id = spacelift_stack.spacelift_testing.id
}
