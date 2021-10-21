resource "aws_lb" "project" {
  name     = "${terraform.workspace}-nginx"

  security_groups = ["${module.loadbalancer.security_group_id}"]
  subnets = flatten([module.vpc.public_subnets])

  enable_deletion_protection = false
}
resource "aws_lb_target_group" "project" {
  name     = "${terraform.workspace}-nginx"
  port     = 80
  protocol = "HTTP"

  vpc_id = "${module.vpc.vpc_id}"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    interval            = "30"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "10"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "project" {
  load_balancer_arn = "${aws_lb.project.arn}"
  port              = "80"
  protocol          = "HTTP"


  default_action {
    target_group_arn = "${aws_lb_target_group.project.arn}"
    type             = "forward"
  }
}

