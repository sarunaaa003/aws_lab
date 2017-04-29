# Kick it off
# Infra is the parent folder and Parent Terraform state where VPC's are being created
#Cmn needs to be changed inline to each new VPC being cloned

provider "aws" {
    region                  = "${var.region}"
    shared_credentials_file = "${var.PARENT_credentials_file}"
    profile                 = "${var.aws_profile}"
}

resource "terraform_remote_state" "infra" {
    backend = "s3"
    config {
        bucket = "${var.PARENT_tf_s3_bucket}"
        key = "${var.PARENT_tf_s3_key}"
        region = "us-east-1"
    }
}

resource "terraform_remote_state" "env" {
    backend = "s3"
    config {
        bucket = "${var.PARENT_tf_s3_bucket}"
        key = "${var.tf_s3_key}"
        region = "us-east-1"
    }
}
