# ## Go into the aws account, and lookup a domain called dns_zone_name
# data "aws_route53_zone" "external" {
#   name         = "${var.dns_zone_name}"
#   private_zone = false
# }


# ## Create a CNAME/ALIAS to the load balancer created in alb.tf
# resource "aws_route53_record" "project" {
#   zone_id = "${data.aws_route53_zone.external.zone_id}"

#   name = "project"
#   type = "A"

#   alias {
#     name                   = "${aws_lb.project.dns_name}"
#     zone_id                = "${aws_lb.project.zone_id}"
#     evaluate_target_health = true
#   }
# }
