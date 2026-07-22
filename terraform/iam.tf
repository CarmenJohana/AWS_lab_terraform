############################
# Forensic Analyst User
############################

resource "aws_iam_user" "forensic_analyst" {

  name = "forensic-analyst"

}



resource "aws_iam_access_key" "forensic_analyst" {

  user = aws_iam_user.forensic_analyst.name

}



############################
# Forensic Analyst Policy
############################

resource "aws_iam_policy" "forensic_analyst" {

  name = "forensic-analyst-policy"

  description = "Read-only permissions for cloud forensic investigation"


  policy = jsonencode({

    Version = "2012-10-17"


    Statement = [


      {

        Sid = "EnvironmentEnumeration"


        Effect = "Allow"


        Action = [

          "ec2:Describe*",

          "elasticloadbalancing:Describe*",

          "autoscaling:Describe*",

          "lambda:Get*",

          "lambda:List*",

          "rds:Describe*",


          "s3:ListAllMyBuckets",

          "s3:GetBucketLocation",

          "s3:GetBucketVersioning",

          "s3:GetBucketAcl",

          "s3:ListBucket",


          "kms:DescribeKey",

          "kms:List*"

        ]


        Resource = "*"

      },


      {

        Sid = "CloudTrailAccess"


        Effect = "Allow"


        Action = [

          "cloudtrail:Get*",

          "cloudtrail:Describe*",

          "cloudtrail:List*",

          "cloudtrail:LookupEvents"

        ]


        Resource = "*"

      },


      {

        Sid = "GuardDutyAccess"


        Effect = "Allow"


        Action = [

          "guardduty:Get*",

          "guardduty:List*"

        ]


        Resource = "*"

      },


      {

        Sid = "SecurityHubAccess"


        Effect = "Allow"


        Action = [

          "securityhub:Get*",

          "securityhub:Describe*",

          "securityhub:List*",

          "securityhub:BatchGet*"

        ]


        Resource = "*"

      },


      {

        Sid = "EvidenceBucketRead"


        Effect = "Allow"


        Action = [

          "s3:GetObject",

          "s3:GetObjectVersion",

          "s3:ListBucket"

        ]


        Resource = [

          aws_s3_bucket.log_archive.arn,

          "${aws_s3_bucket.log_archive.arn}/*"

        ]

      },


      {

        Sid = "SnapshotAcquisition"


        Effect = "Allow"


        Action = [

          "ec2:DescribeSnapshots",

          "ec2:DescribeVolumes",

          "ec2:DescribeInstances",

          "ec2:DescribeInstanceAttribute",

          "ec2:DescribeInstanceStatus",

          "ec2:CreateSnapshot"

        ]


        Resource = "*"

      },


      {

        Sid = "IdentityVerification"


        Effect = "Allow"


        Action = [

          "sts:GetCallerIdentity"

        ]


        Resource = "*"

      }


    ]

  })

}



resource "aws_iam_user_policy_attachment" "forensic_analyst" {


  user = aws_iam_user.forensic_analyst.name


  policy_arn = aws_iam_policy.forensic_analyst.arn


}





############################
# Attacker User
############################

resource "aws_iam_user" "attacker" {

  name = "attacker"

}



resource "aws_iam_access_key" "attacker" {

  user = aws_iam_user.attacker.name

}



resource "aws_iam_policy" "attacker" {

  name = "attacker-policy"


  description = "Limited permissions simulating compromised credentials"


  policy = jsonencode({

    Version = "2012-10-17"


    Statement = [


      {

        Sid = "Discovery"


        Effect = "Allow"


        Action = [

          "ec2:DescribeInstances",

          "ec2:DescribeVpcs",

          "ec2:DescribeSecurityGroups",

          "s3:ListAllMyBuckets"

        ]


        Resource = "*"

      }


    ]

  })

}



resource "aws_iam_user_policy_attachment" "attacker" {


  user = aws_iam_user.attacker.name


  policy_arn = aws_iam_policy.attacker.arn


}