resource "spacelift_policy" "pr_messaging" {
  name = "PR Push commenting"
  body = file("policies/pr_messaging.rego")
  type = "GIT_PUSH"
}
