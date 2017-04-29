##########################################################################
# By creating a SG in a VPC, Terraform removes the default VPC SG thereby
# setting default to ALLOW NONE
# Default - None necessary
# Security Groups are stateful, are allow only (no deny rules)
##########################################################################
# SG_COMMON_PUBLIC
##########################################################################
resource "aws_security_group" "SG_COMMON_PUBLIC" {
    name            = "${var.environment}01 PUBLIC"
    vpc_id          = "${terraform_remote_state.infra.output.VPC_CMN_ID}" #replace "VPC_CMN" for relevant VPC's
    tags {
      "Terraform"   = "true"
      "Name"        = "${var.environment}01 Public Base"
      "Owner"       = "${var.generic_owner}"
    }
    egress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
