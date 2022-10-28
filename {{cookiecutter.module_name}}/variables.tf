// Declare here the variables this module requires
variable "environment" {
  type        = string
  description = "The AWS account this module is deployed to"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace this resource is part of"
  default     = "{{ cookiecutter.namespace }}"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
  default     = "{{ cookiecutter.module_name }}"
}

variable "region" {
  type        = string
  description = "The name of the AWS region"
}

variable "short_desc" {
  type        = string
  description = "A short description for this module"
  default     = "{{ cookiecutter.short_description }}"
}
