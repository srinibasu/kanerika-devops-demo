# Configure remote s3 backend for storing the terraform state. 
# Refer documentation here: https://developer.hashicorp.com/terraform/language/settings/backends/s3
terraform {
  backend "s3" {
    bucket = "srinibasu-backendstate"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
