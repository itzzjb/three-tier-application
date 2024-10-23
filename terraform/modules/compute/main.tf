resource "aws_instance" "public-instance" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t2.micro" # Free tier eligible
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_security_group_id]

  tags = {
    Name = "public-instance"
  }
}

resource "aws_instance" "private-instance" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t2.micro" # Free tier eligible
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_security_group_id]

  tags = {
    Name = "private-instance"
  }
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
