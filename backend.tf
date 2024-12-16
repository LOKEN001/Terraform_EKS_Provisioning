
#  create S3 bucket on aws to stotre the tfstate file

terraform {
  backend "s3" {
    bucket = "lokis3bucket000112"
    key    = "main/jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}