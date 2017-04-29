##########################################################################
##########################################################################
#Used only to create Routes for the VPC or Subnets
#May required Modification on need basis - Required Route Table and Association is in place on the 2 Subnet's
##########################################################################
resource "aws_route" "RT_LOCAL_PUBLIC_TO_EXTERNAL" {
  route_table_id = "${aws_route_table.RT_LOCAL_PUBLIC.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.IGW.id}"
}
