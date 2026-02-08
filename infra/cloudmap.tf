resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = "${var.project_name}.local"
  description = "Private namespace for ECS service discovery"
  vpc         = aws_vpc.main.id
}

resource "aws_service_discovery_service" "main" {
  for_each = var.services
  
  name = replace(each.key, "_", "-")

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.main.id

    dns_records {
      type = "A"
      ttl  = 10
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}