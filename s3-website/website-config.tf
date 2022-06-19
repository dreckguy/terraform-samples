resource "aws_s3_bucket_website_configuration" "default" {
  bucket = aws_s3_bucket.files.id
  index_document {
    suffix = "index.html"
  }

  }