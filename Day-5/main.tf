provider "aws" {
  region = "ap-south-1"
}
resource "aws_key_pair" "tf-key" {
  key_name = "tf-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public-tf" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf_vpc.id
}
resource "aws_route_table" "tf-rt" {
  vpc_id = aws_vpc.tf_vpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  }
resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.public-tf.id
  route_table_id = aws_route_table.tf-rt.id
}

resource "aws_security_group" "app-sg" {
  description = "sg for ec2"
  name = "app-sg"
  vpc_id = aws_vpc.tf_vpc.id
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "server" {
  tags ={
    Name= "tf-ec2"
  }
  subnet_id = aws_subnet.public-tf.id
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  ami="ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  key_name = aws_key_pair.tf-key.key_name

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }
   # File provisioner to copy a file from local to the remote EC2 instance
   # To use provisioner we need to write connection block as well
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }
  # The remote-exec provisioner tells Terraform to log into the newly created EC2 instance (using the SSH connection block and private key)
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",
      "sudo apt install -y python3-flask",  # <-- Changed this line to use apt instead of pip
      "cd /home/ubuntu",
      "sudo python3 app.py &"
    ]
  }
  
}