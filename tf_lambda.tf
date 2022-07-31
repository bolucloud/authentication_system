resource "aws_lambda_function" "authentication_system_backend" {
  function_name = "authentication_system_backend"
  role          = aws_iam_role.authentication_system_lambda_role.arn
  memory_size   = 500
  timeout       = 10
  handler       = "index.js"
  runtime       = "nodejs14.x"
}

resource "aws_lambda_permission" "auth_system_rest_api_gateway_lambda_perm" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authentication_system_backend.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.authentication_system_rest_api_gateway.id}/*/${aws_api_gateway_method.health_get_method.http_method}${aws_api_gateway_resource.authentication_system_api_health_resource.path}"
}
