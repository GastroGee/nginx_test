
resource "aws_lb" "project" {
  name     = "project"

  security_groups = ["${module.loadbalancer.security_group_id}"]
  subnets = [ "${element(module.vpc.private_subnets, var.desired_size)}" ]

#  load_balancer_type         = "network"
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "project" {
  name     = "project"
  port     = 80
  protocol = "HTTP"

  vpc_id = "${module.vpc.vpc_id}"

  health_check {
    path                = "/nginx_status"
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

  # ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  # certificate_arn   = "${data.aws_acm_certificate.project.arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.project.arn}"
    type             = "forward"
  }
}

