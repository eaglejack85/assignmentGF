output lb_id {
  value = aws_lb.my_app_lb.id
}

output autoscaling_group_id {
  value = aws_autoscaling_group.my_asg.id
}

output lb_hostname {
  value = aws_lb.my_app_lb.dns_name
}


output "ami_name" {
  value = data.aws_ami.latest_ami.name
}