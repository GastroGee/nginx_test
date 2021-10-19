resource "aws_s3_bucket" "project" {
  bucket = "project"
  acl    = "private"

  tags = {
    Name        = "project"
    Environment = "testing"
  }
}

resource "aws_s3_bucket_object" "conf" {
  bucket = "${aws_s3_bucket.project.arn}"
  key    = "webconf"
  source = "${file("${path.module}/templates/web.conf")}"
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.project.arn}"
  key    = "webconf"
  source = "${file("${path.module}/templates/index.html")}"
}
