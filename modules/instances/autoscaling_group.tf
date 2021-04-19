/* The ASG */
resource "aws_autoscaling_group" "my_asg" {
  max_size = 5
  min_size = 1

  desired_capacity = 2
  vpc_zone_identifier = [var.private_subnet_id]
  load_balancers      = [aws_lb.my_app_lb.id]
  launch_template {
    id = aws_launch_template.my_webserver_launch_template.id
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

}

/* The aws launch template defining instance shape and AMI, cloud init script, ssh keys and attached ebs volumes */
resource "aws_launch_template" "my_webserver_launch_template" {
  image_id      = data.aws_ami.latest_ami.id
  instance_type = var.instance_shape
  user_data = data.template_cloudinit_config.config.rendered
  key_name  = "webserver-key"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
      encrypted   = true
    }
  }
  block_device_mappings {
    device_name = "/dev/sdv1"

    ebs {
      volume_size = 20
      encrypted   = false
    }
  }
}