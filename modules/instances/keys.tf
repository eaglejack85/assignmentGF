resource "tls_private_key" "key_generation" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "my_private_key" {
  depends_on        = [tls_private_key.key_generation]
  filename          = "${path.root}/generated/${var.environment}_rsa"
  sensitive_content = tls_private_key.key_generation.private_key_pem

  provisioner "local-exec" {
    command = "chmod 400 ${path.root}/generated/${var.environment}_rsa"
  }
}

resource "local_file" "my_public_key" {
  depends_on        = [tls_private_key.key_generation]
  filename          = "${path.root}/generated/${var.environment}_rsa.pub"
  sensitive_content = tls_private_key.key_generation.public_key_pem
}

resource "aws_key_pair" "webserver_ssh_key" {
  key_name = "webserver-key"
  public_key = trimspace(tls_private_key.key_generation.public_key_openssh)
}