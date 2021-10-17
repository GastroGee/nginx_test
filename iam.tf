resource "aws_iam_role" "project" {
  name = "project"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
    EOF
}

//  Create a instance profile for the role.
resource "aws_iam_instance_profile" "project" {
  name = "project"
  role = "${aws_iam_role.project.name}"
}

// This policy allows an instance access to parameter store, cloud watch etc
resource "aws_iam_role_policy" "project" {
  name   = "project"
  role   = "${aws_iam_role.project.id}"
  policy = "${file("${path.module}/templates/iam.json")}"
}