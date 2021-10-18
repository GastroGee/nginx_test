resource "aws_s3_bucket" "project" {
  bucket = "project"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "project" {
  bucket = "${aws_s3_bucket.project.arn}"
  key    = "webconf"
  source = "${file("${path.module}/templates/web.conf")}"
}


