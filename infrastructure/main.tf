# creating the vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app-vpc"
  }
}

# creating the internet gateway for the vpc
resource "aws_internet_gateway" "internet-gateway" {
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

# creating the elastic ip for the nat gateway (required)
resource "aws_eip" "nat-eip" {
  domain = "vpc"
  tags = {
    Name = "app-nat-gateway-eip"
  }
}

# creating the nat gateway
resource "aws_nat_gateway" "nat-gateway" {
  subnet_id     = aws_subnet.public-subnet.id # nat gateway is created in the public subnet
  allocation_id = aws_eip.nat-eip.id          # allocating the eip
  tags = {
    Name = "app-nat-gateway"
  }
}

# creating the route table for the public subnet
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "app-public-route-table"
  }
}

# creating the routes (the entries) of the public route table
# local routes are already setuped
# route to the internet gateway
resource "aws_route" "pubic-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet-gateway.id
}

# associating the public route table to the pubic subnet
resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

# creating the route table for the private subnet
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "app-private-route-table"
  }
}

# creating the routes (the entries) of the private route table
# local routes are already setuped
# route to the nat gateway
resource "aws_route" "private-route" {
  route_table_id         = aws_route_table_association.private-rta.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat-gateway.id
}

# associating the private route table to the private subnet
resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
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

# creating a key pair for ssh
resource "aws_key_pair" "ssh-key-pair" {
  key_name = "three-tier-key"
  # we need to setup a key value pair locally and giving the public key here
  public_key = file("C:/Users/januda.bethmin.de.si/.ssh/three-tier-key.pub")
}

# creating the ec2 instance in the public subnet
resource "aws_instance" "public-instance" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ami.id
  subnet_id     = aws_subnet.public-subnet.id
  key_name = aws_key_pair.ssh-key-pair.key_name
  security_groups = [aws_security_group.public-security-group.id]
  tags = {
    Name = "app-public-instance"
  }
}

# creating the ec2 instance in the private subnet
resource "aws_instance" "private-instance" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ami.id
  subnet_id     = aws_subnet.private-subnet.id
  key_name = aws_key_pair.ssh-key-pair.key_name
  security_groups = [aws_security_group.private-security-group.id]
  tags = {
    Name = "app-private-instance"
  }
}
