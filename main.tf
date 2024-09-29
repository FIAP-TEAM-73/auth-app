provider "aws" {
  region = var.region
}

resource "aws_apigatewayv2_api" "api-tech-challenge-73" {
  name          = "api-tech-challenge-73"
  protocol_type = "HTTP"
}

locals {
  first_listener_arn = keys(data.aws_lb_listener.listener)[0]
}

resource "aws_apigatewayv2_integration" "integration-tech-challenge-73" {
  api_id           = aws_apigatewayv2_api.api-tech-challenge-73.id
  #credentials_arn  = aws_iam_role.example.arn
  description      = "Example with a load balancer"
  integration_type = "HTTP_PROXY"
  integration_uri  = data.aws_lb_listener.listener[local.first_listener_arn].arn
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpc-link-tech-challenge.id
}

resource "aws_apigatewayv2_route" "route-tech-challenge-37" {
  api_id    = aws_apigatewayv2_api.api-tech-challenge-73.id
  route_key = "ANY /{proxy+}"

  target = "integrations/${aws_apigatewayv2_integration.integration-tech-challenge-73.id}"
  authorization_type = "NONE"
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
  api_id = aws_apigatewayv2_api.api-tech-challenge-73.id
  name   = "$default"
  auto_deploy = true
}