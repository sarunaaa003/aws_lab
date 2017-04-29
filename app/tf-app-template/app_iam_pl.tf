#ROUTE 53 PHZ Access
resource "aws_iam_policy" "r53" {
    name = "customer-${lower(var.environment)}-${var.stack}-r53" #Replace Cusotmer with Client attribute, Update Hosted Zone arn
    path = "/"
    description = "Hosts add themselves to route53 private hosted zone"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:ChangeResourceRecordSets",
                "route53:GetHostedZone",
                "route53:ListResourceRecordSets"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:route53:::hostedzone/Z20AD1NKSN5Y2P"
            ]
        },
        {
            "Action": [
                "route53:ListHostedZones"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "r53-policy-attach" {
    name = "customer-${lower(var.environment)}-${var.stack}-r53"#Replace Cusotmer with Client attribute
    roles = ["${aws_iam_role.app.name}"]
    policy_arn = "${aws_iam_policy.r53.arn}"
  }
