resource "aws_iam_role_policy" "policy" {
  name = "${var.role_name}-route53-policy"
  role = "${aws_iam_role.role.id}"

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "route53:ListHostedZones"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "route53:GetHostedZone"
         ],
         "Resource": "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
      },
      {
         "Effect": "Allow",
         "Action": [
            "route53:ListResourceRecordSets"
         ],
         "Resource": "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
      },
      {
         "Effect": "Allow",
         "Action": [
            "route53:ChangeResourceRecordSets"
         ],
         "Resource": "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
      }
   ]
}
EOF
}
