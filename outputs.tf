output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "public_subnet_id2" {
  value = module.network.public_subnet_id2
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "autoscaling_group_id" {
  value = module.instances.autoscaling_group_id
}

output "lb_id" {
  value = module.instances.lb_id
}

output "lb_hostname" {
  value = module.instances.lb_hostname
}