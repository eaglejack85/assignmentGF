# assignmentGF - `instances` module

##Description
This module creates the autoscaling group resources: instances and a application load balancer

##Files
###autoscaling_group.tf
Creates the following resources:
- aws_autoscaling_group
- aws_launch_template

###data.tf
Definition of the following data sources:
- `aws_ami.latest_ami`: returns the latest AMI based on the ingested variables:
- - `ami_owners`: the AMI owner
    
- - `ami_name`: a regular expression defining the AMI name
    
- `template_cloudinit_config.config`: returns the cloud init script for launching the autoscaling group instances

###keys.tf
Creates ssh private and public keys for ssh access to autoscaling group instances.
The generated keys will be stored under `<project root folder>/generated` folder

###lb.tf
Creates a public application load balancer assigned to the public subnets

###outputs.tf
Returns the following data:
- `lb_id`: the public application load balancer id
- `autoscaling_group_id`: the autoscaling group id
- `lb_hostname`: the dns name of the public application load balancer

###variables.tf
no default values defined for variables, causing the calling module to pass all values

###templates/cloud_config.yaml.tpl
cloud init template file:
- mounts `/var/log` mountpoint to an attached ebs volume
- installs an `httpd` webserver
- adds the default user to the `sudoers` list