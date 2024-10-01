resource "aws_apigatewayv2_route" "default-route-tech-challenge-37" {
  api_id        = aws_apigatewayv2_api.api-tech-challenge-73.id
  route_key     = "ANY /{proxy+}"
  target        = "integrations/${aws_apigatewayv2_integration.integration-tech-challenge-73.id}"
  authorizer_id = "NONE"
}

resource "aws_apigatewayv2_route" "route-tech-challenge-37" {
  api_id        = aws_apigatewayv2_api.api-tech-challenge-73.id
  route_key     = "ANY /api/v1{proxy+}"
  target        = "integrations/${aws_apigatewayv2_integration.integration-tech-challenge-73.id}"
  authorizer_id = aws_apigatewayv2_authorizer.lambda-authorizer.id
}

resource "aws_apigatewayv2_route" "route-validate-customer" {
  api_id             = aws_apigatewayv2_api.api-tech-challenge-73.id
  route_key          = "GET /api/v1/customer/{cpf}"
  target             = "integrations/${aws_apigatewayv2_integration.integration-tech-challenge-73.id}"
  authorization_type = "NONE"
}

resource "aws_apigatewayv2_route" "route-swagger" {
  api_id             = aws_apigatewayv2_api.api-tech-challenge-73.id
  route_key          = "GET /swagger"
  target             = "integrations/${aws_apigatewayv2_integration.integration-tech-challenge-73.id}"
  authorization_type = "NONE"
}

resource "aws_apigatewayv2_route" "route-authentication" {
  api_id             = aws_apigatewayv2_api.api-tech-challenge-73.id
  route_key          = "POST /customer/validate"
  target             = "integrations/${aws_apigatewayv2_integration.lambda-integration.id}"
  authorization_type = "NONE"
}