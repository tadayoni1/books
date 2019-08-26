# This module creates a launch configuration for a jenkins server
data "template_file" "launch" {
  template = "${file("${path.module}/user-data.sh.tpl")}"
}

resource "aws_launch_configuration" "lc" {
  name_prefix          = "${var.EnvironmentName}-lc-"
  image_id             = "${var.jenkins_image_id}"
  instance_type        = "${var.jenkins_instance_type}"
  key_name             = "${var.jenkins_instance_key_name}"
  security_groups      = ["${aws_security_group.jenkins_server.id}"]
  user_data            = "${data.template_file.launch.rendered}"

  root_block_device {
    volume_type = "standard"
    volume_size = "8"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "lt" {
  name                 = "${var.EnvironmentName}-lt"
  image_id             = "${var.jenkins_image_id}"
  instance_type        = "${var.jenkins_instance_type}"
  key_name             = "${var.jenkins_instance_key_name}"
  security_groups      = ["${aws_security_group.jenkins_server.id}"]
  user_data            = "${base64encode(data.template_file.launch.rendered)}"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.EnvironmentName}-jenkins"
    }
  }

}


resource "aws_security_group_rule" "ingress_instance_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]

  security_group_id        = "${aws_security_group.jenkins_server.id}"
}

resource "aws_security_group_rule" "egress_instance_all" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]

  security_group_id        = "${aws_security_group.jenkins_server.id}"
}

resource "aws_security_group_rule" "ingress_jenkins_server_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]

  security_group_id        = "${aws_security_group.jenkins_server.id}"
}

resource "aws_security_group" "jenkins_server" {
  name        = "${var.EnvironmentName}-sg-webserver"
  description = "Allow http traffic to/from Web Server"

  tags = {
    Name = "${var.EnvironmentName}-sg-web-server"
  }

}