locals {
  first_listener_arn = keys(data.aws_lb_listener.listener)[0]
}

resource "aws_apigatewayv2_integration" "integration-tech-challenge-73" {
  api_id             = aws_apigatewayv2_api.api-tech-challenge-73.id
  description        = "Integration with Backoffice LB"
  integration_type   = "HTTP_PROXY"
  integration_uri    = data.aws_lb_listener.listener[local.first_listener_arn].arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpc-link-tech-challenge.id
}

resource "aws_apigatewayv2_integration" "lambda-integration" {
  api_id             = aws_apigatewayv2_api.api-tech-challenge-73.id
  integration_type   = "AWS_PROXY"
  integration_uri    = "arn:aws:lambda:us-east-1:${var.account_id}:function:${var.customer_validate_function_name}"
  integration_method = "POST"
}
