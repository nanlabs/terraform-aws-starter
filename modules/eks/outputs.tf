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
