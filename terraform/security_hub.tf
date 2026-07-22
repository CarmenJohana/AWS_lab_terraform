############################
# Enable Security Hub
############################

resource "aws_securityhub_account" "main" {

  enable_default_standards = false

}