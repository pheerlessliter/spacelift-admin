terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.17.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}
