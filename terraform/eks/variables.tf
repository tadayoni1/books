variable aws_region {}
variable "cluster-name" {
  default = "terraform-eks-books"
  type    = "string"
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "route_table_cidr_block" {}
variable my_workstations_ip {}
variable launch_configuration_instance_type {}
