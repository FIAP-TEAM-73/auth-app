data "aws_lbs" "lb-tags" {
  tags = {
    "kubernetes.io/service-name" = "default/svc-api"
  }

}

data "aws_lb" "lb-tech-challenge-73" {
  for_each = toset(data.aws_lbs.lb-tags.arns)
  arn      = each.value
}


data "aws_lb_listener" "listener" {
  for_each          = data.aws_lb.lb-tech-challenge-73
  load_balancer_arn = each.value.arn
  port              = 80
}

data "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

# data "aws_lambda_functions" "all" {}

# data "aws_lambda_function" "lf" {
#   for_each      = toset(data.aws_lambda_functions.all.function_names)
#   function_name = each.value
# }