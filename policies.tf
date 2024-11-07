resource "spacelift_policy" "pr_messaging" {
  name = "PR Push commenting"
  body = file("policies/pr_messaging.rego")
  type = "GIT_PUSH"
}

resource "spacelift_policy_attachment" "pr_messaging" {
  policy_id = spacelift_policy.pr_messaging.id
  stack_id  = spacelift_stack.spacelift_testing.id
}
