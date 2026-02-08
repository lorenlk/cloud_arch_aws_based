output "alb_dns" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "ecs_services" {
  description = "List of ECS service ARNs by id"
  value = {
    for s_name, s in aws_ecs_service.services : s_name => s.id
  }
}

output "redis_endpoint" {
  description = "Redis cluster endpoint"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "redis_port" {
  description = "Redis cluster port"
  value       = aws_elasticache_cluster.redis.port
}

# Frontend S3 bucket
output "frontend_bucket" {
  description = "S3 bucket for frontend"
  value       = aws_s3_bucket.frontend.id
}

# CloudFront distribution ID
output "frontend_cloudfront_id" {
  description = "CloudFront distribution ID for frontend"
  value       = aws_cloudfront_distribution.frontend.id
}

# CloudFront domain (optional)
output "frontend_cloudfront_domain" {
  description = "CloudFront URL for frontend"
  value       = aws_cloudfront_distribution.frontend.domain_name
}
