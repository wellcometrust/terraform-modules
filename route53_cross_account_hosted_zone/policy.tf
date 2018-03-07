resource "aws_iam_role_policy" "policy" {
  name  = "${var.role_name}-route53-policy"
  role  = "${aws_iam_role.role.id}"
  count = "${var.hosted_zone_ids}"

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
         "Resource": "arn:aws:route53:::hostedzone/${element(var.hosted_zone_ids, count.index)}"
      },
      {
         "Effect": "Allow",
         "Action": [
            "route53:ListResourceRecordSets"
         ],
         "Resource": "arn:aws:route53:::hostedzone/${element(var.hosted_zone_ids, count.index)}"
      },
      {
         "Effect": "Allow",
         "Action": [
            "route53:ChangeResourceRecordSets"
         ],
         "Resource": "arn:aws:route53:::hostedzone/${element(var.hosted_zone_ids, count.index)}"
      }
   ]
}
EOF
}
