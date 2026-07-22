############################
# Evidence Storage Bucket
############################

resource "aws_s3_bucket" "log_archive" {

  bucket = var.evidence_bucket_name


  tags = {

    Name = "log-archive"

  }

}



############################
# Enable Bucket Versioning
############################

resource "aws_s3_bucket_versioning" "log_archive" {

  bucket = aws_s3_bucket.log_archive.id


  versioning_configuration {

    status = "Enabled"

  }

}



############################
# Server-Side Encryption
# SSE-S3 (AES256)
############################

resource "aws_s3_bucket_server_side_encryption_configuration" "log_archive" {

  bucket = aws_s3_bucket.log_archive.id


  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}



############################
# Block Public Access
############################

resource "aws_s3_bucket_public_access_block" "log_archive" {

  bucket = aws_s3_bucket.log_archive.id


  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}