provider "aws" {
  region = var.region
}

terraform {
  /*
  See https://www.terraform.io/docs/backends/config.html#partial-configuration for details on how to configure the
  backend.
  */
  backend "s3" {
    bucket         = "{{ cookiecutter.terraform_state_bucket }}"
    dynamodb_table = "{{ cookiecutter.terraform_lock_table }}"
    key            = "resources/{{ cookiecutter.resource_type }}/{{ cookiecutter.module_name|replace('.', '/') }}/project.tfstate"
  }
}
