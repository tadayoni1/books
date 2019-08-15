variable "cluster-name" {
  default = "terraform-eks-books"
  type    = "string"
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "route_table_cidr_block" {}