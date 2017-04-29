## Ingress
resource "aws_security_group_rule" "app_self_ingress" {
  security_group_id = "${aws_security_group.app.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = -1
  self = true
}
resource "aws_security_group_rule" "app_22" {
  security_group_id = "${aws_security_group.app.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
#  source_security_group_id = "${aws_security_group.manager.id}"
}
## Egress
resource "aws_security_group_rule" "app_self_egress" {
  security_group_id = "${aws_security_group.app.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  self = true
}
resource "aws_security_group_rule" "app_proxy_egress_443" {
  security_group_id = "${aws_security_group.app.id}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
#  source_security_group_id = "${var.sg_proxy}"
}
