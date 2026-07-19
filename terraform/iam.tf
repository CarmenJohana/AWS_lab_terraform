############################
# Terraform Admin User
############################

resource "aws_iam_user" "admin_terraform" {
  name = "Admin user"
}

resource "aws_iam_access_key" "admin_terraform" {
  user = aws_iam_user.admin_terraform.name
}

resource "aws_iam_user_policy_attachment" "admin_terraform" {
  user       = aws_iam_user.admin_terraform.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


############################
# Forensic Analyst User
############################

resource "aws_iam_user" "forensic_analyst" {
  name = "Forensic analyst user"
}

resource "aws_iam_access_key" "forensic_analyst" {
  user = aws_iam_user.forensic_analyst.name
}


# Managed Policies

resource "aws_iam_user_policy_attachment" "forensic_analyst_athena" {
  user       = aws_iam_user.forensic_analyst.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

resource "aws_iam_user_policy_attachment" "forensic_analyst_guardduty" {
  user       = aws_iam_user.forensic_analyst.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonGuardDutyReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "forensic_analyst_password" {
  user       = aws_iam_user.forensic_analyst.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_user_policy_attachment" "forensic_analyst_securityaudit" {
  user       = aws_iam_user.forensic_analyst.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}


# Custom forensic policy

resource "aws_iam_policy" "forensic_analyst" {

  name        = "forensic-analyst-user-carmen-lab-1-policy"
  description = "IAM policy for forensic analyst user"

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
          "s3:GetBucketPolicy",
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
          "cloudtrail:LookupEvents",
          "cloudtrail:Get*",
          "cloudtrail:Describe*",
          "cloudtrail:List*"
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
        Sid = "IAMReadOnly"

        Effect = "Allow"

        Action = [
          "iam:Get*",
          "iam:List*",
          "iam:GenerateServiceLastAccessedDetails",
          "iam:GetServiceLastAccessedDetails"
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
          "arn:aws:s3:::dfir-log-archive-lab-1-carmen",
          "arn:aws:s3:::dfir-log-archive-lab-1-carmen/*"
        ]
      },


      {
        Sid = "EvidenceBucketWrite"

        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = "arn:aws:s3:::dfir-log-archive-lab-1-carmen/*"
      },


      {
        Sid = "EvidenceAcquisition"

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


resource "aws_iam_user_policy_attachment" "forensic_analyst_custom" {

  user       = aws_iam_user.forensic_analyst.name
  policy_arn = aws_iam_policy.forensic_analyst.arn

}



############################
# Attacker User
############################

resource "aws_iam_user" "attacker_user" {

  name = "Attacker user"

}


resource "aws_iam_access_key" "attacker_user" {

  user = aws_iam_user.attacker_user.name

}


resource "aws_iam_user_policy_attachment" "attacker_password" {

  user       = aws_iam_user.attacker_user.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"

}


resource "aws_iam_policy" "attacker_user" {

  name        = "attacker-user-policy"
  description = "IAM policy for attacker user"


  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Sid = "EnvironmentEnumeration"

        Effect = "Allow"

        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVpcs",
          "s3:ListAllMyBuckets"
        ]

        Resource = "*"

      }

    ]

  })

}


resource "aws_iam_user_policy_attachment" "attacker_user" {

  user       = aws_iam_user.attacker_user.name
  policy_arn = aws_iam_policy.attacker_user.arn

}