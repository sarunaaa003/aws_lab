/*
resource "aws_route53_zone" "R53_PRIVATE_ZONE" {
  name = "casa.net"
  vpc_id = "${aws_vpc.vpc_cmn.id}" #This is required to make this Zone a Private Hosted Zone
}
*/
