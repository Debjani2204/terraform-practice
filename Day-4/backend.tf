terraform {
  backend "s3" {
    bucket = "debjani-terraform-tfstate"
    key    = "debjani/terraform.tfstate"
    region = "ap-south-1"
    terraform_lock="terraform_lock"
  }
}
