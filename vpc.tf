# Create VPC
resource "aws_vpc" "terra-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terra-vpc"
  }
}

# Creating 3 public subnets

resource "aws_subnet" "terra-sub-pub-1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.ZONE1
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-sub-pub-1"
  }
}

resource "aws_subnet" "terra-sub-pub-2" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.ZONE2
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-sub-pub-2"
  }
}

resource "aws_subnet" "terra-sub-pub-3" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = var.ZONE3
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-sub-pub-3"
  }
}

# Creating 3 private subnets
resource "aws_subnet" "terra-sub-priv-1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = var.ZONE1
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-sub-priv-1"
  }
}

resource "aws_subnet" "terra-sub-priv-2" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = var.ZONE2
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-sub-priv-2"
  }
}

resource "aws_subnet" "terra-sub-priv-3" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = var.ZONE3
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-sub-priv-3"
  }
}

# Creating internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-IGW"
  }
}

# Creating route table

resource "aws_route_table" "terra-RT" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "terra-RT"
  }
}

# Route table assosiations 

resource "aws_route_table_association" "pub-1-assosiation" {
  subnet_id      = aws_subnet.terra-sub-pub-1.id
  route_table_id = aws_route_table.terra-RT.id
}

resource "aws_route_table_association" "pub-2-assosiation" {
  subnet_id      = aws_subnet.terra-sub-pub-2.id
  route_table_id = aws_route_table.terra-RT.id
}

resource "aws_route_table_association" "pub-3-assosiation" {
  subnet_id      = aws_subnet.terra-sub-pub-3.id
  route_table_id = aws_route_table.terra-RT.id
}


# Creating security group

resource "aws_security_group" "terra-sg" {
  name        = "terra-sg"
  description = "terra-sg"
  vpc_id      = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-connection" {
  security_group_id = aws_security_group.terra-sg.id

  cidr_ipv4   = "31.172.137.251/32"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-connection" {
  security_group_id = aws_security_group.terra-sg.id

  cidr_ipv4   = "31.172.137.251/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "allow-ssh-connection" {
  security_group_id = aws_security_group.terra-sg.id

  from_port   = 0
  to_port     = 0
  ip_protocol    = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}