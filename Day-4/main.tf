provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Example" {
  ami = "ami-0ac7b260cf76d8865"
  instance_type = "t3.micro"
}

resource "aws_dynamodb_table" "dyno" {
  name = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}