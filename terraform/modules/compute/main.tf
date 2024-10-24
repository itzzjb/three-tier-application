# creating security group for the public instance
resource "aws_security_group" "public-security-group" {
  name        = "app-public-security-group"
  description = "this security group allows ssh, http and https"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "app-public-security-group"
  }
}

# creating security group for the private instance
resource "aws_security_group" "private-security-group" {
  name        = "private-security-group"
  description = "this security group alloes only ssh"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "app-private-security-group"
  }
}

# creating a key pair for ssh
resource "aws_key_pair" "ssh-key-pair" {
  key_name = "three-tier-key"
  # we need to setup a key value pair locally and giving the public key here
  # this is recieved from github secrets from the workflow as an input variable or terraform
  public_key = var.ssh_public_key
}

# creating the ec2 instance in the public subnet
resource "aws_instance" "public-instance" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.ami.id
  subnet_id       = var.public_subnet_id
  key_name        = aws_key_pair.ssh-key-pair.key_name
  security_groups = [aws_security_group.public-security-group.id]
  tags = {
    Name = "app-public-instance"
  }
}

# creating the ec2 instance in the private subnet
resource "aws_instance" "private-instance" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.ami.id
  subnet_id       = var.private_subnet_id
  key_name        = aws_key_pair.ssh-key-pair.key_name
  security_groups = [aws_security_group.private-security-group.id]
  tags = {
    Name = "app-private-instance"
  }
}