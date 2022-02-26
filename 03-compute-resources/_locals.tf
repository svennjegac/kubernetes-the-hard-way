# VPC
locals {
  cidr_all = "0.0.0.0/0"

  vpc_cidr         = "10.240.0.0/16"
  subnet_cidr      = "10.240.0.0/24"
  fake_subnet_cidr = "10.240.167.0/24"
  subnet_az        = "eu-central-1a"
  fake_subnet_az   = "eu-central-1b"

  ssh_protocol   = "6"
  https_protocol = "6"
  icmp_protocol  = "1"

  k8s_cidr = "10.200.0.0/16"
}

# EC2
locals {
  ubuntu_ami    = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"

  worker_name      = "worker"
  num_workers      = 3
  worker_ip_prefix = "10.240.0.2"
  workers = [
    for i in range(0, 3) :
    {
      name       = "${local.worker_name}-${i}"
      private_ip = "${local.worker_ip_prefix}${i}"
    }
  ]
}
