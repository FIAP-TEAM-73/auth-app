variable "region" {
  default = "us-east-1"
}

variable "customer_validate_function_name" {
  description = "Customer validate function name"
  type        = string
}

variable "authorizer_function_name" {
  description = "Authorizer function name"
  type        = string
}

variable "account_id" {
  type        = string
  description = "AWS Academy account id"
}

variable "default_security_group" {
  type        = string
  description = "AWS Academy default security group"
}