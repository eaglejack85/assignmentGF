terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

module network {
  source              = "./modules/network"
  vpc_cidr            = var.vpc_cidr
  environment         = var.environment
  public_subnet_cidr  = var.public_subnet_cidr
  public_subnet_cidr2 = var.public_subnet_cidr2
  private_subnet_cidr = var.private_subnet_cidr
}

module instances {
  source            = "./modules/instances"
  instance_shape    = var.instance_shape
  environment       = var.environment
  private_subnet_id = module.network.private_subnet_id
  public_subnet_id  = module.network.public_subnet_id
  public_subnet_id2 = module.network.public_subnet_id2
  ami_name          = var.ami_name
  ami_owners        = var.ami_owners
  user_name         = var.user_name
  security_group_id = module.network.security_group_id
}