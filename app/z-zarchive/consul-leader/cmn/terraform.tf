provider "aws" {
    region                  = "${var.region}"
    shared_credentials_file = "${var.PARENT_credentials_file}"
    profile                 = "${var.aws_profile}"
}

# Consumes environment's remote state.
resource "terraform_remote_state" "cmn" {
    backend = "s3"
    config {
        bucket = "${var.PARENT_tf_s3_bucket}"
        key = "${var.tf_s3_key}"
        region = "us-east-1"
    }
}
