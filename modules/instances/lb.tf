resource "aws_lb" "my_app_lb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_id, var.public_subnet_id2]

  enable_deletion_protection = true
  
  tags = {
    Environment = var.environment
  }
}
