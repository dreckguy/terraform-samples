resource "aws_s3_bucket" "files" {
  bucket = "ophirus-test-bucket"

  tags = {
    Name        = "Ophirus Test bucket"
  }
}