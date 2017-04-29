# Template Stack
provider "aws" {
    region                  = "${var.region}"
    shared_credentials_file = "${var.shared_credentials_file}"
    profile                 = "${var.aws_profile}"
}

# Exposes parent env remote state.
resource "terraform_remote_state" "env" {
    backend       = "s3"
    config        = {
        bucket    = "${var.PARENT_tf_s3_bucket}"
        key       = "${var.tf_s3_key}"
        region    = "${var.region}"
    }
}

# Consumed by all apps in stack
resource "aws_security_group" "default" {
  name = "${lower(var.environment)}-${var.stack}-base"
  vpc_id = "${terraform_remote_state.env.output.ENV_VPC_ID}"
  tags {
    Name      = "${lower(var.environment)}-${var.stack}-base"
    env       = "${lower(var.environment)}"
    owner     = "${var.owner}"
    stack     = "${var.stack}"
    unit      = "${var.business_unit}"
    terraform = "True"
  }
}
