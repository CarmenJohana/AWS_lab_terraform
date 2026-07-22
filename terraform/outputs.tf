############################
# Networking Outputs
############################

output "workload_vpc_id" {

  description = "ID of the workload VPC"

  value = aws_vpc.workload.id

}


output "sandbox_vpc_id" {

  description = "ID of the sandbox VPC"

  value = aws_vpc.sandbox.id

}



############################
# EC2 Outputs
############################

output "workload_instance_id" {

  description = "ID of workload EC2 instance"

  value = aws_instance.workload.id

}



output "velociraptor_server_public_ip" {

  description = "Public IP address of Velociraptor server"

  value = aws_instance.velociraptor_server.public_ip

}



output "velociraptor_server_private_ip" {

  description = "Private IP address of Velociraptor server"

  value = aws_instance.velociraptor_server.private_ip

}



output "velociraptor_client_private_ip" {

  description = "Private IP address of Velociraptor client"

  value = aws_instance.velociraptor_client.private_ip

}



output "attacker_public_ip" {

  description = "Public IP address of attacker instance"

  value = aws_instance.attacker.public_ip

}



############################
# Evidence Storage Outputs
############################

output "evidence_bucket_name" {

  description = "S3 bucket used for forensic evidence storage"

  value = aws_s3_bucket.log_archive.bucket

}



output "evidence_bucket_arn" {

  description = "ARN of evidence bucket"

  value = aws_s3_bucket.log_archive.arn

}



############################
# Security Monitoring Outputs
############################

output "cloudtrail_name" {

  description = "CloudTrail trail name"

  value = aws_cloudtrail.main.name

}



output "guardduty_detector_id" {

  description = "GuardDuty detector identifier"

  value = aws_guardduty_detector.main.id

}