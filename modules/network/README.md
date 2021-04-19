# assignmentGF - `network` module

##Description
This module creates the networking part of vpc, subnets, Internet and NAT gateways, route tables and routes.
The public subnet is associated with a route table that has a route to an Internet gateway.
The Internet gateway connects the VPC to the Internet and to other AWS services.
The private subnet is associated with a route table that has a route to a NAT gateway.
A NAT gateway has its own Elastic IPv4 address. Instances in the private subnet can send requests to the Internet through the NAT gateway over IPv4 (for example, for software updates).

##Files

###outputs.tf
Returns the following data:
- `private_subnet_id`: the private subnet id used as value for vpc_zone_identifier of the autoscaling group
- `public_subnet_id, public_subnet_id2`: the public subnets ids used as value for `subnets` argument of the public application load balancer
- `vpc_id`: the vpc id returned to the root module outputs
- `security_group_id`: the security group id used as value for `security_groups` argument of the public application load balancer

###security_groups.tf
Creates the security groups for the private and public subnets.
Allow http and https connection to the load balancer.
Allow ssh access to the autoscaling group instances.
Allow all outbound traffic from both load balancer and autoscaling group instances.

###subnets.tf
Creates:
- two public subnets (on 2 availability zones because of application load balancer requirement, I could have implemented a smarter way of spanning subnet over all availability zones, didn't have time for it, so created the minimum required number of subnets required by the application load balancer)
- a private subnet
- a route table for the public subnet and a route to the Internet gateway
- a route table for the private subnet and a route to the NAT gateway

###variables.tf
no default values defined for variables, causing the calling module to pass all values

###vpc.tf
Creates:
- a vpc
- an Internet gateway
- a NAT gateway
- an elastic IP for the NAT gateway