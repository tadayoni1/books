resource "aws_eks_cluster" "books" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.books-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.books-cluster.id}"]
    subnet_ids         = ["${aws_subnet.books.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.books-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.books-cluster-AmazonEKSServicePolicy",
  ]
}