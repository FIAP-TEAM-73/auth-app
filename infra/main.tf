provider "aws" {
  region = var.region
}

resource "aws_apigatewayv2_api" "api-tech-challenge-73" {
  name          = "api-tech-challenge-73"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_vpc_link" "vpc-link-tech-challenge" {
  name               = "vpc-link-tech-challenge"
  security_group_ids = ["sg-03994733d8fddaebd"]
  subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.region}e"]

  tags = {
    Usage = "vpc-link-tech-challenge"
  }
}

resource "aws_apigatewayv2_stage" "stage-tech-challenge-73" {
  api_id      = aws_apigatewayv2_api.api-tech-challenge-73.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "allow_api_gateway_invoke" {
  statement_id  = "AllowApiGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-east-1:245903023069:function:${var.customer_validate_function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api-tech-challenge-73.execution_arn}/*/*/customer/validate"
}

resource "aws_lambda_permission" "allow_authorizer" {
  statement_id  = "AllowAuthorizerInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-east-1:245903023069:function:${var.authorizer_function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api-tech-challenge-73.execution_arn}/*/*"
}
