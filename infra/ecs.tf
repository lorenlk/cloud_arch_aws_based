resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "tasks" {
  for_each = var.services

  family                   = "${var.project_name}-${each.key}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = each.key
      image     = "485898089185.dkr.ecr.${var.aws_region}.amazonaws.com/${each.key}:latest"
      essential = true
      portMappings = [
        {
          containerPort = each.value.port
          hostPort      = each.value.port
          protocol      = "tcp"
        }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:${each.value.port}/health || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }
    }
  ])
}

resource "aws_ecs_service" "services" {
  for_each = var.services

  name            = "${var.project_name}-${each.key}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.tasks[each.key].arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = each.value.expose ? [1] : []

    content {
      target_group_arn = aws_lb_target_group.targets[each.key].arn
      container_name   = each.key
      container_port   = each.value.port
    }
  }

  depends_on = [aws_lb_listener.http]
}

resource "aws_lb_target_group" "targets" {
  for_each = {
    for svc_name, svc_conf in var.services : 
    svc_name => svc_conf
    if svc_conf.expose
  }
  name        = replace("${var.project_name}-${each.key}", "_", "-")
  port        = each.value.port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 15
    timeout             = 5
    matcher             = "200"
  }
}

resource "aws_lb_listener_rule" "routes" {
  for_each = {
    for svc_name, svc_conf in var.services :
    svc_name => svc_conf
    if svc_conf.expose
  }

  listener_arn = aws_lb_listener.http.arn
  priority     = 100 + index(keys(var.services), each.key)

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targets[each.key].arn
  }

  condition {
    path_pattern {
      values = ["${each.value.path_prefix}/*"]
    }
  }
}