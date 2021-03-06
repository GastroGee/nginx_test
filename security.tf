module "loadbalancer" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group"
  name        = "project"
  description = "80 to Loadbalancer"

  egress_with_cidr_blocks = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "outbound"
      from_port   = -1
      to_port     = -1
      protocol    = "all"
    },
  ]

  ingress_with_cidr_blocks = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "http"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
  ]

  vpc_id = "${module.vpc.vpc_id}"
}


module "asg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group"
  name        = "project"
  description = "allow 80 to ASG"

  egress_with_cidr_blocks = [
    {
      cidr_blocks = "0.0.0.0/0"
      description = "outbound"
      from_port   = -1
      to_port     = -1
      protocol    = "all"
    },
  ]

  ingress_with_cidr_blocks = [
    {
      cidr_blocks = "${var.allowed_incoming_ssh}"
      description = "ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
  ]
  vpc_id = "${module.vpc.vpc_id}"
}