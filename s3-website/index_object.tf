locals{
    index_path = "./index.html"
  }

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.files.id
  key    = "index.html"
  source = local.index_path
  etag = filemd5(local.index_path)
  content_type = "text/html"
  acl = "public-read"
}