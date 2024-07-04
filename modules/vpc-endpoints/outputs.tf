output "endpoints" {
  description = "IDs of the VPC endpoints"
  value       = module.vpc_endpoints.endpoints
}
