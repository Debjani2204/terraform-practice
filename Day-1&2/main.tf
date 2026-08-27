provider "aws"{
    region= "ap-south-1"
}

variable "enable_ssh" {
  description = "SSH Connection"
  type = bool
  default = false
}
resource "aws_instance" "terraform_instance" {
  ami           = "ami-0ac7b260cf76d8865"
  instance_type = "t3.micro"
  key_name = "ce-prod-key"
  tags = {
    Name = "TF"
  }
  security_groups = [aws_security_group.terraform_instance_sg.name]
}

resource "aws_security_group" "terraform_instance_sg" {
  name = "TF-sg"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.enable_ssh ? ["0.0.0.0/0"] : []
  }
}

output "TF-instance-SG" {
  value = aws_security_group.terraform_instance_sg.name
}

output "Public-Ip" {
  value = aws_instance.terraform_instance.public_ip
}