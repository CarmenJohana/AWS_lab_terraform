############################
# CloudTrail S3 Bucket Policy
############################

resource "aws_s3_bucket_policy" "cloudtrail" {

  bucket = aws_s3_bucket.log_archive.id


  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Sid = "AWSCloudTrailAclCheck"

        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action = "s3:GetBucketAcl"

        Resource = aws_s3_bucket.log_archive.arn

      },


      {

        Sid = "AWSCloudTrailWrite"

        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action = "s3:PutObject"

        Resource = "${aws_s3_bucket.log_archive.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"


        Condition = {

          StringEquals = {

            "s3:x-amz-acl" = "bucket-owner-full-control"

          }

        }

      }

    ]

  })

}



############################
# CloudTrail Trail
############################

resource "aws_cloudtrail" "main" {

  name = local.cloudtrail_name


  s3_bucket_name = aws_s3_bucket.log_archive.id


  include_global_service_events = true


  is_multi_region_trail = true


  enable_log_file_validation = true



  ############################
  # Management Events
  ############################

  event_selector {

    read_write_type = "All"

    include_management_events = true


    # Data events intentionally disabled
    # because this laboratory does not require
    # object-level activity tracking.

  }



  tags = {

    Name = local.cloudtrail_name

  }

}