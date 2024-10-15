output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks_cluster.eks_cluster_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks_cluster.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with your cluster"
  value       = module.eks_cluster.eks_cluster_certificate_authority_data
}

output "eks_cluster_managed_security_group_id" {
  value = module.eks_cluster.eks_cluster_managed_security_group_id
}

output "eks_cluster_node_group_roles_arns" {
  description = "The ARNs of the IAM roles associated with the EKS cluster node groups"
  value       = [for ng in module.eks_node_groups : ng.eks_node_group_role_arn]
}

output "eks_cluster_node_group_roles_names" {
  description = "The names of the IAM roles associated with the EKS cluster node groups"
  value       = [for ng in module.eks_node_groups : ng.eks_node_group_role_name]
}
