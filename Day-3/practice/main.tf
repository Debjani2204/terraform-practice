provider "aws" {
  region = "ap-south-1"
}

module "multiple-ec2" {
  for_each = var.server-config
  source = "../module/ec2_instance"
  ami_value = each.value.ami_id
  instance_type_value = each.value.instance_type_val
  key_pair = each.value.key_pair_name
}