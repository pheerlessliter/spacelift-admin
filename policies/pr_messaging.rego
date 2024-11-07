package spacelift

# 🦕 Feel free to remove commented code once your policy is ready. 🦕
#
# ⚠️ Git push only take effect once attached to a Stack or Module ⚠️
#
# Git push policy can be used to determine the action that should be taken in
# response to a git push notification. Three actions are possible:
#
# - track: create a run that can be applied;
# - propose: create a test run against proposed version of infrastructure;
# - ignore: do nothing;
#
# As input, Git push policy receives the following document:
{
  "push": {
    "affected_files": ["string"],
    "author": "string",
    "branch": "string",
    "created_at": "number (timestamp in nanoseconds)",
    "message": "string",
    "tag": "string"
  },
  "stack": {
    "administrative": "boolean",
    "autodeploy: "boolean",
    "autoretry: "boolean",
    "branch": "string",
    "id": "string",
    "labels": ["string"],
    "locked_by": "string or null",
    "name": "string",
    "namespace": "string or null",
    "project_root": "string or null",
    "repository": "string",
    "state": "string",
    "terraform_version": "string or null"
  },
  "module": {
    "administrative": "boolean",
    "branch": "string",
    "id": "string",
    "labels": ["string"],
    "name": "string",
    "namespace": "string or null",
    "repository": "string",
    "terraform_provider": "string",
  }
}
#
# Based on this input, the policy may define boolean "track", "propose" and
# "ignore" rules. Positive outcome of at least one "ignore" rule causes the push
# to be ignored. Positive outcome of at least one "track" rule triggers a
# tracked run. Positive outcome of at least one "propose" rule triggers a
# proposed run. If no rules are matched, the default is to **ignore** the push.
# It is also possible to define an auxiliary rule called "ignore_track", which
# overrides a positive outcome of the "track" rule but does not affect other
# rules, most importantly "propose". This can be used to turn into test runs
# some of the pushes that would otherwise be applied.
#
# Here's a few things you can do with Git push policies:
#
# 1) Ignore certain paths
#
# track {
#   input.push.branch == input.stack.branch
# }
#
# propose {
#   input.push.branch != ""
# }
#
# ignore {
#   not affected
# }
#
# affected {
#   filepath := input.push.affected_files[_]
#   startswith(filepath, "production/")
#   endswith(filepath, ".tf")
# }
#
# 2) Only apply things that are tagged using semver scheme (major.minor.patch):
#
# track {
#   re_match(`^\d+\.\d+\.\d+$`, input.push.tag)
# }
#
# propose {
#   true
# }
#
# Now go ahead and unleash your inner lawgiver. For more information on the rule
# language, please visit https://www.openpolicyagent.org/docs/latest/
