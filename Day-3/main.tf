provider "aws" {
  region = "ap-south-1"
}

module "ec2" {
  source = "./module/ec2_instance"
  ami_value = var.ami_id
  instance_type_value = var.instance_type_id
  key_pair = var.key_pair_file
}