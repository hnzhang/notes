the lab from 
Introduction to AWS Identity and Access Management (IAM)

A user has a sign in URL


# ManagedPolcies
Managed Polices are pre-built policies either by AWS or by your administrators that can be attached to IAM Users and groups.

Sampel Policy (copied from AmazonEC2ReadOnlyAccess)
This policy is granting permission to **List** and **Describe** information about EC2, Elastic Load Balancing, CouldWatch, and Auto Scaling.
```JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:Describe*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:Describe*",
      "Resource": "*"
    }
  ]
}
```
