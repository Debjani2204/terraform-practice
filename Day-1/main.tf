provider "aws"{
    region= "ap-south-1"
}

resource "aws_instance" "terraform_instance" {
  ami           = "ami-0ac7b260cf76d8865"
  instance_type = "t3.micro"
  key_name = "ce-prod-key"
  tags = {
    Name = "HelloWorld"
  }
}