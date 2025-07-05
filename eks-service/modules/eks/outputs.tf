output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.this.token
}

output "node_group_role_arn" {
  value = aws_iam_role.node_group.arn
}
