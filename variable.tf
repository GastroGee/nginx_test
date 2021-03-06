variable "nginx_version" {
    description = "version of nginx to be install"
    default = "1.18.0"
}

variable "image_id" {
    description = "AMI to use"
    default= "ami-09e67e426f25ce0d7"
}

variable "instance_type" {
    description = "Type of instance"
    default = "t2.medium"
}

variable "ssh_keyname" {
    default = "test"
}

variable "min_size" {
    default = 1
}

variable "max_size" {
    default = 5
}

variable "desired_size" {
    default = 3
}

variable "health_check_type" {
    default = "EC2"
}

variable "health_check_grace_period" {
    default = 300
}

variable "wait_for_capacity_timeout" {
    default = "10m"
}


variable "allowed_incoming_ssh" {
    default = "0.0.0.0/0"
}
