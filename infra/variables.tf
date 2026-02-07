variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
  default     = "demo-app"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "availability_zones" {
  description = "Availability Zones to use"
  type        = list(string)
  default     = [
    "eu-west-1a",
    "eu-west-1b"
  ]
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks per service"
  type        = number
  default     = 2
}

variable "services" {
  description = "List of backend services and exposure"
  type = map(object({
    port        = number
    expose      = bool
    path_prefix = string
  }))
  default = {
    service_a = { port = 8000, expose = true, path_prefix = "/a" }
    service_b = { port = 8001, expose = true, path_prefix = "/b" }
    service_c = { port = 8002, expose = false, path_prefix = "" }
    service_d = { port = 8003, expose = false, path_prefix = "" }
    service_e = { port = 8004, expose = true, path_prefix = "/e" }
    service_f = { port = 8005, expose = false, path_prefix = "" }
  }
}