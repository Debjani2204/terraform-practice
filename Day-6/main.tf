provider "aws" {
  region = "ap-south-1"
}

variable "ami_root_var" {
  description = "value"
}

variable "instance_type_root_var" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "c7i-flex.large"
  }
}
module "ec2" {
  source = "./modules/ec2_instance"
  ami_var = var.ami_root_var
  instance_type_var = lookup(var.instance_type_root_var,terraform.workspace)
}
