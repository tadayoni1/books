# IAM
resource "aws_iam_role" "books-node" {
  name = "terraform-eks-books-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "books-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.books-node.name}"
}

resource "aws_iam_role_policy_attachment" "books-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.books-node.name}"
}

resource "aws_iam_role_policy_attachment" "books-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.books-node.name}"
}

resource "aws_iam_instance_profile" "books-node" {
  name = "terraform-eks-books"
  role = "${aws_iam_role.books-node.name}"
}



# Security Groups
resource "aws_security_group" "books-node" {
  name        = "terraform-eks-books-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.books.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "terraform-eks-books-node",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "books-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.books-node.id}"
  source_security_group_id = "${aws_security_group.books-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "books-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.books-node.id}"
  source_security_group_id = "${aws_security_group.books-cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}