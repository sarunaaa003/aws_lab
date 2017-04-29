##########################################################################
# We set this to deny all as we will specify rules on a per subnet basis.
# NACL only manages egress, Ingress is managed by Security Groups
# Flush default vpc nacl - DENY ALL BY OMMITTING
# www.terraform.io/docs/providers/aws/r/default_network_acl.html
##########################################################################
##########################################################################
# NACL_COMMON_PUBLIC
#Only Required Rules needs to be edited
##########################################################################
resource "aws_network_acl" "NACL_LOCAL_PUBLIC" {
  vpc_id = "${terraform_remote_state.infra.output.VPC_QAT_ID}" #replace "VPC_CMN" for relevant VPC's
  subnet_ids = ["${aws_subnet.SN_LOCAL_PUBLIC.*.id}"]
  tags {
      Terraform = "true"
      Name = "${var.environment}_Public"
  }
}

resource "aws_network_acl_rule" "NACL_LOCAL_PUBLIC_INGRESS" {
  network_acl_id = "${aws_network_acl.NACL_LOCAL_PUBLIC.id}"
  rule_number = 99
  egress = false
  protocol = "all"
  rule_action = "allow"
  cidr_block =  "0.0.0.0/0"
  from_port = 0
  to_port = 0
}
resource "aws_network_acl_rule" "NACL_LOCAL_PUBLIC_EGRESS" {
  network_acl_id = "${aws_network_acl.NACL_LOCAL_PUBLIC.id}"
  rule_number = 99
  egress = true
  protocol = "all"
  rule_action = "allow"
  cidr_block =  "0.0.0.0/0"
  from_port = 0
  to_port = 0
}
