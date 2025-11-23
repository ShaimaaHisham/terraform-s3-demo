provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "aws-terraform-s3-bucket-test"

}

# Configure S3 static website
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.demo_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload local index.html file to bucket
resource "aws_s3_object" "index_file" {
  bucket  = aws_s3_bucket.demo_bucket.id
  key     = "index.html"
  source  = "index.html"        # local file path
  etag    = filemd5("index.html")
}
