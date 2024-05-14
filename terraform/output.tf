output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = "dev"
}

output "Github_action_Access_key_id" {
  value = module.iam.Github_action_Access_key_id
}

output "Github_action_Access_key_secret" {
  value = module.iam.Github_action_Access_key_secret
}

output "k8_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "eks_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "eks_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "eks_name" {
  description = "Kubernetes Cluster Name"
  value       = "dev"
}