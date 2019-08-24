variable aws_region {}
variable "cluster-name" {
  default = "terraform-eks-books"
  type    = "string"
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "route_table_cidr_block" {}
variable my_workstations_ip {}



# Jenkins
variable jenkins_launch_configuration_instance_type {}
variable "jenkins_instance_key_name" {}
variable "EnvironmentName" {}
variable "jenkins_image_id" {}
variable "jenkins_instance_type" {}
