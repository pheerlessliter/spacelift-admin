resource "spacelift_space" "poc" {
  name             = "PoC"
  parent_space_id  = "root"
  description      = "Proof of concept space for testing and discovery"
  inherit_entities = true
}
