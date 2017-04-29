################################################################################
#IAM ROLE
################################################################################
resource "aws_iam_role" "bind_app" {
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
resource "aws_iam_instance_profile" "bind_app" {
  name  = "${var.environment}-${var.stack}_app"
  roles = ["${aws_iam_role.bind_app.name}"]
}
################################################################################
#SECURITY GROUP SPECIFIC TO APP
################################################################################
resource "aws_security_group" "bind_app" {
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
  /*ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  */
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }

  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.cidr_cmn}",]
  }
  /*ingress {
      from_port = 53
      to_port = 53
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }

  egress {
    from_port = 53
    to_port = 53
    protocol = "tcp"
    cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 53
      to_port = 53
      protocol = "udp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }

  egress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = ["${var.cidr_cmn}",]
  }*/
}

resource "aws_launch_configuration" "bind_app" {
  name_prefix          = "${var.environment}-${var.stack}-"
  image_id             = "${var.app_ami}"
  instance_type        = "${var.app_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.bind_app.id}"
  key_name             = "${var.keypair}"
  associate_public_ip_address = false
  security_groups = [
    "${aws_security_group.bind_app.id}",
    "${terraform_remote_state.cmn.output.SG_COMMON_PRIVATE_ID}"
  ]
  user_data         = "${file("scripts/bootstrap.sh")}"
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
  depends_on = ["aws_security_group.bind_app"]
}

resource "aws_autoscaling_group" "bind_app" {
  vpc_zone_identifier = ["${split(",", terraform_remote_state.cmn.output.ENV_PRIVATE_SUBNET_LIST)}"]
  name             = "${var.environment}-${var.stack}"
  max_size         = "${var.app_count_max}"
  min_size         = "${var.app_count_min}"
  desired_capacity = "${var.app_count_desired}"
  health_check_grace_period = 100
  health_check_type    = "EC2"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.bind_app.name}"

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
    "aws_launch_configuration.bind_app",
    "aws_security_group.bind_app"
  ]
}
