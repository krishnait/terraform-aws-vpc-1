resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet" {
  count = "${var.subnets}"

  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block, var.subnets, count.index)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }
}

resource "aws_route_table" "routing_table" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "association" {
  count = "${aws_subnet.subnet.count}"

  route_table_id = "${aws_route_table.table.id}"
  subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
}
