variable "ami_var" {
  description = "value"
}

variable "instance_type_var" {
  description = "value"
}


resource "aws_instance" "eg" {
  ami = var.ami_var
  instance_type = var.instance_type_var
}