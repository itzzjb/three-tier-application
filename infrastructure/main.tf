# creating the vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app-vpc"
  }
}

# creating the internet gateway for the vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "app-internet-gateway"
  }
}

# creating the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a" # availabilty zone is required for subnets
  map_public_ip_on_launch = true         # this will make this a public subnet
  tags = {
    Name = "app-public-subnet"
  }
}

# creating the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "app-private-subnet"
  }
}

# creating the route table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "app-route-table"
  }
}

# creating security group for the public instance
resource "aws_security_group" "public-security-group" {
  name        = "app-public-security-group"
  description = "this security group allows ssh, http and https"
  vpc_id      = aws_vpc.vpc.id
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
  vpc_id      = aws_vpc.vpc.id
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

# creating the ec2 instance in the public subnet
resource "aws_instance" "public-instance" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ami.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
    Name = "app-public-instance"
  }
}

# creating the ec2 instance in the private subnet
resource "aws_instance" "private-instance" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ami.id
  subnet_id     = aws_subnet.private-subnet.id
  tags = {
    Name = "app-private-instance"
  }
}
