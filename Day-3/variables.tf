variable "ami_id" {
  description = "value will get passed to ami_value in module via terraform.tfstate"
}

variable "instance_type_id" {
  description = "value will get passed to instance_type_value in module via terraform.tfstate"
}

variable "key_pair_file" {
  description = "value will get passed to key_pair in module via terraform.tfstate"
}