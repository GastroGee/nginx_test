
data "template_file" "nginx" {
  template = "${file("${path.module}/templates/nginx.sh")}"
}

resource "aws_launch_configuration" "project" {
  name_prefix                 = "${terraform.workspace}-nginx"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.project.name}"
  key_name                    = "${var.ssh_keyname}"
  user_data                   = "${data.template_file.nginx.rendered}"
  security_groups             = ["${module.asg.security_group_id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "project" {
  launch_configuration        = "${aws_launch_configuration.project.name}"

  name_prefix                 = "project"
  availability_zones          = flatten([module.vpc.private_subnets])

  min_size                      = "${var.min_size}"
  max_size                      = "${var.max_size}"
  desired_capacity              = "${var.desired_size}"
  target_group_arns             = ["${aws_lb_target_group.project.arn}"]

  health_check_type         = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "project" {
  autoscaling_group_name = "${aws_autoscaling_group.project.id}"
  alb_target_group_arn  = "${aws_lb_target_group.project.arn}"
}