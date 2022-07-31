resource "aws_api_gateway_rest_api" "authentication_system_rest_api_gateway" {
  name        = "authentication_system_rest_api_gateway"
  description = "This is the API for the serverless authentication system"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# the resources below are for the /health path
resource "aws_api_gateway_resource" "authentication_system_api_health_resource" {
  rest_api_id = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.root_resource_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "health_get_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.authentication_system_api_health_resource.id
  rest_api_id   = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
}

resource "aws_api_gateway_method_response" "health_get_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
  resource_id = aws_api_gateway_resource.authentication_system_api_health_resource.id
  http_method = aws_api_gateway_method.health_get_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
  depends_on = [aws_api_gateway_method.health_get_method]
}

resource "aws_api_gateway_integration" "health_get_method_integration" {
  http_method             = aws_api_gateway_method.health_get_method.http_method
  resource_id             = aws_api_gateway_resource.authentication_system_api_health_resource.id
  rest_api_id             = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.authentication_system_backend.invoke_arn
  integration_http_method = "POST"
  depends_on = [
    aws_api_gateway_method.health_get_method
  ]
}

resource "aws_api_gateway_integration_response" "health_get_method_integration_response" {
  http_method = aws_api_gateway_method.health_get_method.http_method
  resource_id = aws_api_gateway_resource.authentication_system_api_health_resource.id
  rest_api_id = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
  status_code = aws_api_gateway_method_response.health_get_method_response_200.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [
    aws_api_gateway_method_response.health_get_method_response_200,
    aws_api_gateway_integration.health_get_method_integration
  ]
}

## Other endpoints go here


##

resource "aws_api_gateway_deployment" "authentication_system_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.authentication_system_api_health_resource.id,
      aws_api_gateway_method.health_get_method.id,
      aws_api_gateway_integration.health_get_method_integration.id
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "authentication_system_api_deployment_stage" {
  deployment_id = aws_api_gateway_deployment.authentication_system_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id
  stage_name    = "prod"
}
