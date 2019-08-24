# General
EnvironmentName                    = "books"


# EKS
aws_region                         = "us-west-2"
vpc_cidr_block                     = "10.0.0.0/16"
subnet_cidr_block                  = "10.0.0.0/24"
route_table_cidr_block             = "0.0.0.0/0"


# Jenkins
jenkins_launch_configuration_instance_type = "m4.large"
jenkins_instance_key_name                  = "automation"
jenkins_image_id                           = "ami-06f2f779464715dc5"
jenkins_instance_type                      = "t2.medium"