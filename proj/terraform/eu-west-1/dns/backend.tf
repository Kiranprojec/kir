
provider "aws" {
  region = "eu-west-1"
}

terraform {


  backend "s3" {
    bucket         = "kiran-tfstate"
    key            = "eu-west-1/dns/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "kiran-terraform-statelock"
  }
}
resource "aws_dynamodb_table" "kiran_terraform_statelock" {
  name           = "kiran-terraform-statelock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform = "true"
  }
}


