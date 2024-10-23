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

# creating another private subnet 
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2c"
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
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat-gateway.id
}

# associating the private route table to the private subnet
resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
}

# associating the private route table to the private subnet 2
resource "aws_route_table_association" "private-rta-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}