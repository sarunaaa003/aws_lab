################################################################################
#IAM ROLE
################################################################################
resource "aws_iam_role" "squid_app" {
  name = "${var.environment}-${var.stack}"
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

resource "aws_iam_role_policy" "squid_app_s3" {
  name = "${var.environment}-${var.stack}"
  role = "${aws_iam_role.squid_app.id}"
  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Effect": "Allow",
    "Action": [
      "s3:Get*",
      "s3:List*"
    ],
    "Resource": "*"
  }
]
}
EOF
}

resource "aws_iam_instance_profile" "squid_app" {
  name  = "${var.environment}-${var.stack}_app"
  roles = ["${aws_iam_role.squid_app.name}"]
}
################################################################################
#SECURITY GROUP SPECIFIC TO APP
################################################################################
resource "aws_security_group" "squid_app" {
  name = "${var.environment}-${var.stack}"
  vpc_id = "${terraform_remote_state.cmn.output.ENV_VPC_ID}"
  tags {
    Name      = "${var.environment}-${var.stack}_app"
    env       = "${var.environment}"
    owner     = "${var.owner}"
    stack     = "${var.stack}"
    unit      = "${var.business_unit}"
    terraform = "True"
  }
  ingress {
      from_port = 3128
      to_port = 3128
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}
################################################################################
#LC SPECIFIC TO APP
################################################################################

resource "aws_launch_configuration" "squid_app" {
  name_prefix          = "${var.environment}-${var.stack}-"
  image_id             = "${var.app_ami}"
  instance_type        = "${var.app_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.squid_app.id}"
  key_name             = "${var.keypair}"
  associate_public_ip_address = true
  security_groups = [
    "${aws_security_group.squid_app.id}",
    ]
  user_data         = "${file("${path.module}/scripts/bootstrap.sh")}"
  ebs_optimized     = false
  enable_monitoring = true
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.app_instance_vol_size}"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_security_group.squid_app"]
}

################################################################################
#ASG SPECIFIC TO APP
################################################################################

resource "aws_autoscaling_group" "squid_app" {
  vpc_zone_identifier = ["${split(",", terraform_remote_state.cmn.output.ENV_PUBLIC_SUBNET_LIST)}"]
  name             = "${var.environment}-${var.stack}"
  max_size         = "${var.app_count_max}"
  min_size         = "${var.app_count_min}"
  desired_capacity = "${var.app_count_desired}"
  health_check_grace_period = 100
  health_check_type    = "EC2"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.squid_app.name}"
  load_balancers            = ["${aws_elb.LB_COMMON_SQUID_PRIVATE.id}"]
  tag {
    key   = "unit"
    value = "${var.business_unit}"
    propagate_at_launch = true
  }
  tag {
    key   = "owner"
    value = "${var.owner}"
    propagate_at_launch = true
  }
  tag {
    key   = "renew"
    value = "${var.renewal_date}"
    propagate_at_launch = true
  }
  tag {
    key   = "stack"
    value = "${var.stack}"
    propagate_at_launch = true
  }
  tag {
    key   = "role"
    value = "${var.role_app}"
    propagate_at_launch = true
  }
  tag {
    key   = "env"
    value = "${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key   = "Name"
    value = "${var.environment}-${var.stack}-app"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    "aws_launch_configuration.squid_app",
    "aws_security_group.squid_app"
  ]
}
################################################################################
#INTERNAL ELB SPECIFIC TO APP
################################################################################

resource "aws_elb" "LB_COMMON_SQUID_PRIVATE" {
  name = "${var.environment}-${var.stack}-Private"
  internal = "true"
  security_groups = ["${aws_security_group.squid_app.id}"]
  subnets = ["${split(",", terraform_remote_state.cmn.output.ENV_PRIVATE_SUBNET_LIST)}"]
  cross_zone_load_balancing = "true"
  listener {
    instance_port = 3128
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:3128"
    interval = 30
  }
  tags {
    "Terraform"   = "true"
    "Name"        = "${var.environment} ${var.stack} Private"
    "Owner"       = "${var.owner}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
#ROUTE 53 RECORD SET SPECIFIC TO APP PRIVATE ELB
################################################################################

resource "aws_route53_record" "squid_app" {
   zone_id = "${terraform_remote_state.cmn.output.R53_PRIVATE_ZONE}"
   name = "${var.environment}-${var.stack}.casa.net"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.LB_COMMON_SQUID_PRIVATE.dns_name}"]
  lifecycle {
     create_before_destroy = true
   }
   depends_on = ["aws_elb.LB_COMMON_SQUID_PRIVATE"]
 }
