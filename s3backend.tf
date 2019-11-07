resource "aws_s3_bucket" "s3backend" {
  bucket = "joeb-s3-backend-${var.environment}"

  versioning {
    enabled = true
  }

  force_destroy = true

  tags = {
    Name        = "S3 Remote Terraform State Store"
    Environment = "${var.environment}"
  }
}

terraform {
  backend "s3" {
    bucket = "joeb-s3-backend-dev"
    key    = "dev/s3state.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "eu-west-1"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
