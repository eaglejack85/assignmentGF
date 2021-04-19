data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/templates/cloud_config.yaml.tpl", { "user_name" = var.user_name })
  }
}