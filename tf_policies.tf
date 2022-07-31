# aws managed cloudwatchlogsfullaccess policy
data "aws_iam_policy" "CloudWatchLogsFullAccess" {
  arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# aws managed amazonddbfullaccess policy
data "aws_iam_policy" "AmazonDynamoDBFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}