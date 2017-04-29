#If there is  a need to create multiple ASG duplicate the file and replace "app"
# resources defined in the following order:
# security group
# launch config and autoscaling group

# r53 record

# elb

# template resource for launch config
# iam policies and instance profile

# resources defined in the following order:
# security group
# launch config and autoscaling group
# app resource for launch config
# iam policies and instance profile

resource "aws_iam_instance_profile" "app" {
  name  = "client-${lower(var.environment)}-${var.stack}-app" #replace client with client name
  roles = ["${aws_iam_role.app.name}"]
}

resource "aws_iam_role" "app" {
  name = "client-${lower(var.environment)}-${var.stack}-app"#replace client with client name
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

# security group for the APP

resource "aws_security_group" "app" {
  name = "${lower(var.environment)}-${var.stack}-app"
  vpc_id = "${terraform_remote_state.env.output.ENV_VPC_ID}"
  tags {
    Name      = "${lower(var.environment)}-${var.stack}-app"
    unit      = "${var.business_unit}"
    owner     = "${var.owner}"
    renew     = "${var.renewal_date}"
    stack     = "${var.stack}"
    role      = "${var.app_role}"
    env       = "${lower(var.environment)}"
    terraform = "True"
  }
}

# Launch Config for the APP
resource "aws_launch_configuration" "app" {
  name_prefix          = "${lower(var.environment)}-${var.stack}-app"
  iam_instance_profile = "${aws_iam_instance_profile.app.id}"
  instance_type        = "${var.app_type}"
  image_id             = "${var.ami_no_proxy}"
  key_name             = "${var.keypair}"
  associate_public_ip_address = true
  security_groups = [
    "${terraform_remote_state.env.output.ENV_PUBLIC_SG}",
    "${aws_security_group.default.id}",
    "${aws_security_group.app.id}"
  ]
  user_data         = "${template_file.app.rendered}"
  ebs_optimized     = false
  enable_monitoring = true
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.app_root_size}"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    "aws_security_group.app",
    "template_file.app"
  ]
}

resource "aws_autoscaling_group" "app" {
  vpc_zone_identifier  = ["${split(",", terraform_remote_state.env.output.ENV_PUBLIC_SUBNET_LIST)}"]#Define Which Subnet on the Target environment the app needs to be launched e.g. "replace PUBLIC to PRIVATE"
  name                 = "${lower(var.environment)}-${var.stack}-app"
  max_size             = "${var.app_count_max}"
  min_size             = "${var.app_count_min}"
  desired_capacity     = "${var.app_count_desired}"
  health_check_type    = "EC2"
  health_check_grace_period = 100
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.app.name}"
  termination_policies = []
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
/*
tags {
    Name      = "${lower(var.environment)}-${var.stack}-app"
    unit      = "${var.business_unit}"
    owner     = "${var.owner}"
    renew     = "${var.renewal_date}"
    stack     = "${var.stack}"
    role      = "${var.app_role}"
    env       = "${lower(var.environment)}"
    terraform = "True"
  }
*/
lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    "aws_launch_configuration.app",
    "aws_security_group.app"
  ]
}
#BOOTSTRAP FILE
resource "template_file" "app" {
  template = "${file("scripts/app.tpl")}"
  vars {
    stack = "${var.stack}"
    environment = "${lower(var.environment)}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
