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

# resource "aws_lambda_permission" "allow_api_gateway_invoke" {
#   statement_id  = "292bef49-6eb4-5193-b27a-b8eebed2540c"  # Unique statement ID
#   action        = "lambda:InvokeFunction"  # Action to allow API Gateway to invoke Lambda
#   function_name = aws_apigatewayv2_route.route-authentication.#"auth-app-CustomerValidateFunction-NF94tTaN1KUs"  # Name of your Lambda function
#   principal     = "apigateway.amazonaws.com"  # API Gateway as the principal (who is allowed to invoke)

#   # Source ARN for the API Gateway route
#   source_arn = "${aws_apigatewayv2_api.api-tech-challenge-73.execution_arn}/*/*/customer/validate"
# }
