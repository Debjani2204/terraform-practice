
resource "aws_instance" "Example" {
  ami = var.ami_value
  instance_type = var.instance_type_value
  key_name = var.key_pair
  tags = {
    Name= "day-3"
  }

}
