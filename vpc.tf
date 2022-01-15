#  TODO = slice(data.aws_availability_zones.available.names, 0, var.number_of_az) 

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main"
  }
}

# resource "aws_subnet" "main-public-1" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = "true"
#   availability_zone       = "eu-west-1a"

#   tags = {
#     Name = "main-public-1"
#   }
# }


resource "aws_subnet" "public" {
  count = var.number_of_azs

  vpc_id                  = aws_vpc.main.id
  cidr_block              = format("10.0.%d.0/24", count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true"
}

# resource "aws_subnet" "private" {
#   count = var.number_of_azs

# vpc_id                  = aws_vpc.main.id
# cidr_block              = format("10.0.%d.0/24", count.index + var.number_of_azs) # Subnets must not to overlap
#   availability_zone = data.aws_availability_zones.available.names[count.index]
#   tags              = local.preparedTags
# }

# resource "aws_route_table" "main-public" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.internet_gateway.id
#   }
#   tags = local.preparedTags
# }

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  count = var.number_of_azs

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "main-private-2"
  }
}

resource "aws_subnet" "main-private-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "main-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# # route associations public
# resource "aws_route_table_association" "main-public-1-a" {
#   subnet_id      = aws_subnet.main-public-1.id
#   route_table_id = aws_route_table.main-public.id
# }

# resource "aws_route_table_association" "main-public-2-a" {
#   subnet_id      = aws_subnet.main-public-2.id
#   route_table_id = aws_route_table.main-public.id
# }

# resource "aws_route_table_association" "main-public-3-a" {
#   subnet_id      = aws_subnet.main-public-3.id
#   route_table_id = aws_route_table.main-public.id
# }

