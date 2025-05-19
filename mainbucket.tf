provider "aws" {
  secret_key = var.aws-secret-key
  access_key = var.aws-access-key
}

#Create an S3 bucket with tags
resource "aws_s3_bucket" "mainbucket" {
  bucket = "main-bucket-inventory"
  force_destroy = "true"
  tags = var.s3-bucket-tags
}

#Assign bucket ownership
resource "aws_s3_bucket_ownership_controls" "bucket-owner" {
  bucket = aws_s3_bucket.mainbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Assign public access 
resource "aws_s3_bucket_public_access_block" "aclblock" {
  bucket = aws_s3_bucket.mainbucket.id
  block_public_acls = var.block-public-acls
  block_public_policy = var.block-public-policy
  ignore_public_acls = var.ignore-public-acls
  restrict_public_buckets = var.restrict-public-buckets
}

#Enable bucket version for the bucket
resource "aws_s3_bucket_versioning" "bucket-versioning" {
  bucket = aws_s3_bucket.mainbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Enable server side encryption and assign it to bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "kms-key-management" {
    depends_on = [ aws_kms_key.bucket-key ]
  bucket = aws_s3_bucket.mainbucket.id
  
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_alias.dept-s3-bucket-key.arn
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_lambda_permission" "lambda-invoke-permission" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-function.arn
  principal = "s3.amazonaws.com"
  source_arn = aws_s3_bucket.mainbucket.arn

}

resource "aws_s3_bucket_notification" "s3-notify-lambda" {
  bucket = aws_s3_bucket.mainbucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda-function.arn
    events = [ "s3:ObjectCreated:*" ]
  }

  depends_on = [ aws_lambda_permission.lambda-invoke-permission ]
}