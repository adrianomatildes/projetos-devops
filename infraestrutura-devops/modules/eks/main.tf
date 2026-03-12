############################
# IAM - NODES
############################
resource "aws_iam_role" "nodes" {
  name               = "${var.name}-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
  tags = merge(var.common_tags, { Name = "${var.name}-node-role" })
}

resource "aws_iam_role_policy_attachment" "node_worker" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}
resource "aws_iam_role_policy_attachment" "node_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}
resource "aws_iam_role_policy_attachment" "node_ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

############################
# IAM - CLUSTER (Control Plane)
############################
resource "aws_iam_role" "cluster" {
  name = "${var.name}-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "eks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
  tags = merge(var.common_tags, { Name = "${var.name}-cluster-role" })
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}
resource "aws_iam_role_policy_attachment" "service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster.name
}

############################
# CLUSTER EKS
############################
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = var.endpoint_public
    endpoint_private_access = var.endpoint_private
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy,
    aws_iam_role_policy_attachment.service_policy
  ]
}

############################
# NODE GROUP
############################
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = var.node_subnet_ids

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types
  labels         = { role = "worker" }
  version        = var.eks_version

  depends_on = [
    aws_iam_role_policy_attachment.node_worker,
    aws_iam_role_policy_attachment.node_cni,
    aws_iam_role_policy_attachment.node_ecr,
    aws_eks_cluster.this
  ]
}