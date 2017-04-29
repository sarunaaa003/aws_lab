# Outputs for consumption by other environments
#outputs needs to be created for each VPC's in its own name so it can be passed on for module consumption on the child folders
output "VPC_CMN_ID" {
  value = "${aws_vpc.vpc_cmn.id}"
}
output "VPC_DEV_ID" {
  value = "${aws_vpc.vpc_dev.id}"
}
output "VPC_QAT_ID" {
  value = "${aws_vpc.vpc_qat.id}"
}
/*output "R53_PRIVATE_ZONE" {
  value = "${aws_route53_zone.R53_PRIVATE_ZONE.id}"
}
*/
output "VPC_PEER_CMN_DEV" {
  value = "${aws_vpc_peering_connection.cmn_dev.id}"
}
output "VPC_PEER_CMN_QAT" {
  value = "${aws_vpc_peering_connection.cmn_qat.id}"
}
/*output "VPC_QATESTG_ID" {
  value = "${aws_vpc.VPC_QATESTG.id}"
}
output "VPC_COMMON_ID" {
  value = "${aws_vpc.VPC_COMMON.id}"
}
output "PC_PEER_COMMON_QATESTG_ID" {
  value = "${aws_vpc_peering_connection.PEER_COMMON_QATESTG.id}"
}
output "PC_PEER_COMMON_DEVMENT_ID" {
  value = "${aws_vpc_peering_connection.PEER_COMMON_DEVMENT.id}"
}
output "RT_COMMON_PUBLIC_ID" {
  value = "${aws_route_table.RT_COMMON_PUBLIC.id}"
}
output "RT_COMMON_PRIVATE_ID" {
  value = "${aws_route_table.RT_COMMON_PRIVATE.id}"
}
output "VPC_DEVMENT_CIDR_BLOCK" {
  value = "${aws_vpc.VPC_DEVMENT.cidr_block}"
}
output "VPC_QATESTG_CIDR_BLOCK" {
  value = "${aws_vpc.VPC_QATESTG.cidr_block}"
}
output "NGW_COMMON_PUBLIC_ID" {
  value = "${aws_nat_gateway.NGW_COMMON_PUBLIC.id}"
}
output "VG_COMMON_ID" {
  value = "${aws_vpn_gateway.VG_COMMON.id}"
}
output "ENV_PUBLIC_SUBNET_LIST" {
  value = "${join(",", aws_subnet.SN_COMMON_PUBLIC.*.id)}"
}
output "ENV_PRIVATE_SUBNET_LIST" {
  value = "${join(",", aws_subnet.SN_COMMON_PRIVATE.*.id)}"
}
output "ENV_VPC_ID" {
  value = "${aws_vpc.VPC_COMMON.id}"
}
output "SG_COMMON_PUBLIC" {
  value = "${aws_security_group.SG_COMMON_PUBLIC.id}"
}
output "SG_COMMON_PRIVATE" {
  value = "${aws_security_group.SG_COMMON_PRIVATE.id}"
}
output "IR_GENERIC_ROLE_NAME" {
  value = "${aws_iam_role.IR_GENERIC_ROLE.name}"
}
output "VPNCGW_DEVSHRD01_ID" {
    value = "${aws_customer_gateway.CG_COMMON.id}"
}

/* For VPN Details
output "VPN_customer_gateway_configuration" {
  value = "${aws_vpn_connection.VC_COMMON.customer_gateway_configuration}"
}
output "VPN_customer_gateway_id" {
  value = "${aws_vpn_connection.VC_COMMON.customer_gateway_id}"
}
output "VPN_static_routes_only" {
  value = "${aws_vpn_connection.VC_COMMON.static_routes_only}"
}
output "VPN_tunnel1_address" {
  value = "${aws_vpn_connection.VC_COMMON.tunnel1_address}"
}
output "VPN_tunnel1_preshared_key" {
  value = "${aws_vpn_connection.VC_COMMON.tunnel1_preshared_key}"
}
output "VPN_tunnel2_address" {
  value = "${aws_vpn_connection.VC_COMMON.tunnel2_address}"
}
output "VPN_tunnel2_preshared_key" {
  value = "${aws_vpn_connection.VC_COMMON.tunnel2_preshared_key}"
}
output "VPN_type" {
  value = "${aws_vpn_connection.VC_COMMON.type}"
}
*/
