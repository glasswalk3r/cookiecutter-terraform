# already specifing the minimal providers versions that any module will require
terraform {
  required_version = ">= 0.12.29"
  required_providers {
    aws   = "~> 2.70"
    local = "~> 1.4"
    null  = "~> 2.1"
  }
}
