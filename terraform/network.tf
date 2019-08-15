data "aws_availability_zones" "available" {}

resource "aws_vpc" "books" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = "${
    map(
     "Name", "terraform-eks-books-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "books" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = replace("${var.subnet_cidr_block}", "/(\d{1,3}\.d{1,3}\.)d{1,3}(\.d{1,3})\/\d{1,2}/", "$1${count.index}$2")
  vpc_id            = "${aws_vpc.books.id}"

  tags = "${
    map(
     "Name", "terraform-eks-books-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "books" {
  vpc_id = "${aws_vpc.books.id}"

  tags = {
    Name = "terraform-eks-books"
  }
}

resource "aws_route_table" "books" {
  vpc_id = "${aws_vpc.books.id}"

  route {
    cidr_block = "${var.route_table_cidr_block}"
    gateway_id = "${aws_internet_gateway.books.id}"
  }
}

resource "aws_route_table_association" "books" {
  count = 2

  subnet_id      = "${aws_subnet.books.*.id[count.index]}"
  route_table_id = "${aws_route_table.books.id}"
}