resource "aws_security_group_rule" "books-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.books-cluster.id}"
  source_security_group_id = "${aws_security_group.books-node.id}"
  to_port                  = 443
  type                     = "ingress"
}