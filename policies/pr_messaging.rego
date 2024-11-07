package spacelift

track   { input.push.branch == input.stack.branch }
propose { not is_null(input.pull_request) }
ignore  { not track; not propose }
