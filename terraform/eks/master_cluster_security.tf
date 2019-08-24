resource "aws_iam_role" "books-cluster" {
  name = "terraform-eks-books-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "books-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.books-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "books-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.books-cluster.name}"
}

resource "aws_security_group" "books-cluster" {
  name        = "terraform-eks-books-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.books.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-books"
  }
}

# Allow inbound traffic from your local workstation external IP to the Kubernetes.
resource "aws_security_group_rule" "books-cluster-ingress-workstation-https" {
  cidr_blocks       = "${var.my_workstations_ip}"
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.books-cluster.id}"
  to_port           = 443
  type              = "ingress"
}