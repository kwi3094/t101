resource "aws_vpc" "w5_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.nick_name}-study"
  }
}

resource "aws_subnet" "w5_public_subnet" {
  for_each = var.public_subnet_map
  vpc_id     = aws_vpc.w5_vpc.id
  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]

  tags = {
    Name = "${var.nick_name}-${each.key}"
  }
}

resource "aws_subnet" "w5_private_subnet" {
  for_each = var.private_subnet_map
  vpc_id     = aws_vpc.w5_vpc.id
  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]

  tags = {
    Name = "${var.nick_name}-${each.key}"
  }
}

resource "aws_internet_gateway" "w5_igw" {
  vpc_id = aws_vpc.w5_vpc.id
  tags = {
    Name = "${var.nick_name}-igw"
  }
}

resource "aws_route_table" "w5_public_rt" {
  vpc_id = aws_vpc.w5_vpc.id
  tags = {
    Name = "${var.nick_name}-public-rt"
  }
}

resource "aws_route_table" "w5_private_rt" {
  vpc_id = aws_vpc.w5_vpc.id
  tags = {
    Name = "${var.nick_name}-private-rt"
  }
}

resource "aws_route" "w5_defaultroute" {
  route_table_id         = aws_route_table.w5_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.w5_igw.id
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each = var.public_subnet_map
  subnet_id      = aws_subnet.w5_public_subnet[each.key].id
  route_table_id = aws_route_table.w5_public_rt.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  for_each = var.private_subnet_map
  subnet_id      = aws_subnet.w5_private_subnet[each.key].id
  route_table_id = aws_route_table.w5_private_rt.id
}


