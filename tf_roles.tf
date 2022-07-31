resource "aws_iam_role" "authentication_system_lambda_role" {
  name = "authentication_system_lambda_role"

  managed_policy_arns = [
    data.aws_iam_policy.CloudWatchLogsFullAccess.arn,
    data.aws_iam_policy.AmazonDynamoDBFullAccess.arn
  ]

  assume_role_policy = <<POLICY
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
  }
  POLICY
}
