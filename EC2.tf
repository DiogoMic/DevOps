provider "aws" {
  region = "eu-west-2" // London region
}

resource "aws_instance" "webserver" {
  ami           = " " // Insert an Amazon Linux 2 AMI ID 
  instance_type = "t2.micro"
  key_name      = "your_key_pair_name" // Replace with your key pair name

  tags = {
    Name = "webserver-instance"
  }
}
resource "aws_vpc" "webserver" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "webserver_subnet" {
  vpc_id     = aws_vpc.webserver.id
  cidr_block = "10.0.0.0/24"
}
resource "aws_security_group" "webserver_security_group" {
  name        = "webserver-security-group"
  description = "Webserver security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.webserver.id
}
