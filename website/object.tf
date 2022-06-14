resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.files.id
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
  acl = "public-read"
}