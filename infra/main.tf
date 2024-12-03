module "svc-api" {
  source                          = "./api-gateways"
  authorizer_function_name        = var.authorizer_function_name
  service_name                    = "svc-api"
  default_security_group          = var.default_security_group
  customer_validate_function_name = var.customer_validate_function_name
  account_id                      = var.account_id
}

module "svc-order-api" {
  source                          = "./api-gateways"
  authorizer_function_name        = var.authorizer_function_name
  service_name                    = "svc-order-api"
  default_security_group          = var.default_security_group
  customer_validate_function_name = var.customer_validate_function_name
  account_id                      = var.account_id
}

module "svc-payment-api" {
  source                          = "./api-gateways"
  authorizer_function_name        = var.authorizer_function_name
  service_name                    = "svc-payment-api"
  default_security_group          = var.default_security_group
  customer_validate_function_name = var.customer_validate_function_name
  account_id                      = var.account_id
}