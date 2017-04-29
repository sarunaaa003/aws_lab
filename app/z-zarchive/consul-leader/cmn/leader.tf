################################################################################
#IAM ROLE
################################################################################

resource "aws_iam_role" "leader_app" {
  name = "${var.environment}-${var.stack}-leader"
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

resource "aws_iam_role_policy" "leader_app_s3" {
  name = "${var.environment}-${var.stack}-leader"
  role = "${aws_iam_role.leader_app.id}"
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

resource "aws_iam_instance_profile" "leader_app" {
  name  = "${var.environment}-${var.stack}-leader"
  roles = ["${aws_iam_role.leader_app.name}"]
}

################################################################################
#SECURITY GROUP SPECIFIC TO APP
################################################################################

resource "aws_security_group" "leader_app" {
  name = "${var.environment}-${var.stack}-leader"
  vpc_id = "${terraform_remote_state.cmn.output.ENV_VPC_ID}"
  tags {
    Name      = "${var.environment}-${var.stack}-leader"
    env       = "${var.environment}"
    owner     = "${var.owner}"
    stack     = "${var.stack}"
    unit      = "${var.business_unit}"
    terraform = "True"
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 8300
      to_port = 8302
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 8400
      to_port = 8400
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 8500
      to_port = 8500
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 8600
      to_port = 8600
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 8301
      to_port = 8302
      protocol = "udp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  ingress {
      from_port = 8600
      to_port = 8600
      protocol = "udp"
      cidr_blocks = ["${var.cidr_cmn}",]
  }
  egress {
      from_port = 0
      to_port = 65535
      protocol = "udp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
/*
resource "aws_security_group" "leader" {
    name = "leader_app"
    description = "leader internal traffic + maintenance."

    // These are for internal traffic
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // These are for maintenance
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // This is for outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
*/

################################################################################
#LC SPECIFIC TO APP
################################################################################

resource "aws_launch_configuration" "leader_app" {
  name_prefix          = "${var.environment}-${var.stack}-leader"
  image_id             = "${var.app_ami}"
  instance_type        = "${var.app_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.leader_app.id}"
  key_name             = "${var.keypair}"
  associate_public_ip_address = false
  security_groups = [
    "${aws_security_group.leader_app.id}",
    ]
  user_data         = "${file("${path.module}/scripts/bootstrap.leader.sh")}"
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
  depends_on = ["aws_security_group.leader_app"]
}


################################################################################
#ASG SPECIFIC TO APP
################################################################################

resource "aws_autoscaling_group" "leader_app" {
  vpc_zone_identifier = ["${split(",", terraform_remote_state.cmn.output.ENV_PRIVATE_SUBNET_LIST)}"]
  name             = "${var.environment}-${var.stack}-leader"
  max_size         = "${var.leader}"
  min_size         = "${var.leader}"
  desired_capacity = "${var.leader}"
  health_check_grace_period = 100
  health_check_type    = "EC2"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.leader_app.name}"

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
    key   = "Name"
    value = "${var.environment}-${var.stack}-leader"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    "aws_launch_configuration.leader_app",
    "aws_security_group.leader_app"
  ]
}
