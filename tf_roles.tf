resource "aws_iam_role" "authentication_system_lambda_role" {
  name = "authentication_system_lambda_role"

  managed_policy_arns = [
    data.aws_iam_policy.CloudWatchLogsFullAccess.arn,
    data.aws_iam_policy.AmazonDynamoDBFullAccess.arn,
    data.aws_iam_policy.AmazonAPIGatewayInvokeFullAccess.arn
  ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "LambdaAssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
