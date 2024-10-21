# creating the vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app-vpc"
  }
}

# creating the internet gateway for the vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = "aws_vpc.vpc.id"
  tags = {
    Name = "app-internet-gateway"
  }
}

# creating the public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "aws_vpc.vpc.id"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a" # availabilty zone is required for subnets
  map_public_ip_on_launch = true         # this will make this a public subnet
  tags = {
    Name = "app-public-subnet"
  }
}

# creating the private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = "aws_vpc.vpc.id"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "app-private-subnet"
  }
}

# creating the route table
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "app-route-table"
    }
}

# creating a route (entry in the route table)




