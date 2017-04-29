resource "aws_subnet" "SN_LOCAL_PUBLIC" {
  vpc_id            = "${terraform_remote_state.infra.output.VPC_DEV_ID}" #replace "VPC_CMN" for relevant VPC's
  count             = "${length(compact(split(",", var.region_azs)))}"
  availability_zone = "${element(split(",", var.region_azs), count.index)}"
  cidr_block        = "${element(split(",", var.cidr_block_public), count.index)}"
  tags {
    "Terraform"     = "true"
    "Name"          = "${var.environment}01_Public ${count.index+1}"
    "Owner"         = "${var.generic_owner}"
  }
  map_public_ip_on_launch = false
}

resource "aws_route_table" "RT_LOCAL_PUBLIC" {
  vpc_id = "${terraform_remote_state.infra.output.VPC_DEV_ID}" #replace "VPC_CMN" for relevant VPC's
  tags {
    "Terraform" = "true"
    "Name"      = "${var.environment}01_Public"
    "Owner"     = "${var.generic_owner}"
  }
}
resource "aws_route_table_association" "RTA_LOCAL_PUBLIC" {
  count          = "${length(compact(split(",", var.region_azs)))}"
  subnet_id      = "${element(aws_subnet.SN_LOCAL_PUBLIC.*.id, count.index)}"
  route_table_id = "${aws_route_table.RT_LOCAL_PUBLIC.id}"
}
