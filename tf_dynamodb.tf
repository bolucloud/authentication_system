resource "aws_dynamodb_table" "authentication_system_ddb_table" {
  name           = "authentication_system_users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "username"

  attribute {
    name = "username"
    type = "S"
  }
}
