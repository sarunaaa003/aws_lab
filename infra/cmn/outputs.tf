#Outputs from the Account Terraform Project
output "ENV_VPC_ID" {
  value = "${terraform_remote_state.infra.output.VPC_CMN_ID}"
}
output "R53_PRIVATE_ZONE" {
  value = "${terraform_remote_state.infra.output.R53_PRIVATE_ZONE}"
}
output "VPC_PEER_CMN_DEV" {
  value = "${terraform_remote_state.infra.output.cmn_dev.id}"
}
output "VPC_PEER_CMN_QAT" {
  value = "${terraform_remote_state.infra.output.cmn_qat.id}"
}
#outputs for this Terraform Project
output "ENV_IGW_ID" {
  value = "${aws_internet_gateway.IGW.id}"
}
output "ENV_PUBLIC_SUBNET_LIST" {
  value = "${join(",", aws_subnet.SN_LOCAL_PUBLIC.*.id)}"
}
output "ENV_PRIVATE_SUBNET_LIST" {
  value = "${join(",", aws_subnet.SN_LOCAL_PRIVATE.*.id)}"
}
output "ENV_PUBLIC_ROUTE_TABLE" {
  value = "${aws_route_table.RT_LOCAL_PUBLIC.id}"
}
output "ENV_PRIVATE_ROUTE_TABLE" {
  value = "${aws_route_table.RT_LOCAL_PRIVATE.id}"
}
output "ENV_S3EP_LOCAL_S3" {
  value = "${aws_vpc_endpoint.S3EP_LOCAL_S3.id}"
}
output "SG_COMMON_PUBLIC_ID" {
  value = "${aws_security_group.SG_COMMON_PUBLIC.id}"
}
output "SG_COMMON_PRIVATE_ID" {
  value = "${aws_security_group.SG_COMMON_PRIVATE.id}"
}
output "SN_LOCAL_PUBLIC.0.id" {
  value = "${aws_subnet.SN_LOCAL_PUBLIC.0.id}"
}
output "SN_LOCAL_PUBLIC.1.id" {
  value = "${aws_subnet.SN_LOCAL_PUBLIC.1.id}"
}
output "SN_LOCAL_PUBLIC.2.id" {
  value = "${aws_subnet.SN_LOCAL_PUBLIC.2.id}"
}
output "SN_LOCAL_PRIVATE.0.id" {
  value = "${aws_subnet.SN_LOCAL_PRIVATE.0.id}"
}
output "SN_LOCAL_PRIVATE.1.id" {
  value = "${aws_subnet.SN_LOCAL_PRIVATE.1.id}"
}
output "SN_LOCAL_PRIVATE.2.id" {
  value = "${aws_subnet.SN_LOCAL_PRIVATE.2.id}"
}
output "NACL_LOCAL_PUBLIC.id" {
  value = "${aws_network_acl.NACL_LOCAL_PUBLIC.id}"
}
output "NACL_LOCAL_PRIVATE.id" {
  value = "${aws_network_acl.NACL_LOCAL_PRIVATE.id}"
}
output "ENV_PUBLIC_SG" {
  value = "${aws_security_group.SG_COMMON_PUBLIC.id}"
}
output "ENV_PRIVATE_SG" {
  value = "${aws_security_group.SG_COMMON_PRIVATE.id}"
}
