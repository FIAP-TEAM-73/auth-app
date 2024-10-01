resource "aws_apigatewayv2_authorizer" "lambda-authorizer" {
  name                              = "lambda-authorizer"
  api_id                            = aws_apigatewayv2_api.api-tech-challenge-73.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:245903023069:function:auth-app-AuthorizerFunction-eboxfP8gj3na/invocations"
  identity_sources                  = ["$request.header.Authorization"]
  authorizer_payload_format_version = "2.0"
}