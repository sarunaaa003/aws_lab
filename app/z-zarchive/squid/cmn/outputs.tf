/*output "SQUID_ELB_PUBLIC_ADDRESS" {
  value = "${aws_elb.LB_COMMON_SQUID_PUBLIC.dns_name}"
}
output "SQUID_ELB_PUBLIC_ZONE_ID" {
  value = "${aws_elb.LB_COMMON_SQUID_PUBLIC.zone_id}"
}*/
output "SQUID_ELB_PRIVATE_ADDRESS" {
  value = "${aws_elb.LB_COMMON_SQUID_PRIVATE.dns_name}"
}
output "SQUID_ELB_PRIVATE_ZONE_ID" {
  value = "${aws_elb.LB_COMMON_SQUID_PRIVATE.zone_id}"
}
output "SQUID_DNS_NAME" {
  value = "${aws_route53_record.squid_app.name}"
}
