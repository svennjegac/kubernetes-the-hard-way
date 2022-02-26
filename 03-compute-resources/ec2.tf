locals {
  ubuntu_ami    = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
}

resource "aws_key_pair" "k8s_key_pair" {
  key_name   = "k8s_ssh_key"
  public_key = var.k8s_ssh_public_key

  tags = {
    Name = "k8s_key_pair"
  }
}

resource "aws_security_group" "k8s_security_group" {
  name   = "k8s_security_group"
  vpc_id = aws_vpc.k8s_main.id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [local.cidr_all]
  }

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [local.subnet_cidr]
  }
  ingress {
    from_port   = 22
    protocol    = local.ssh_protocol
    to_port     = 22
    cidr_blocks = [local.cidr_all]
  }
  ingress {
    from_port   = 443
    protocol    = local.https_protocol
    to_port     = 443
    cidr_blocks = [local.cidr_all]
  }
  ingress {
    from_port   = 6443
    protocol    = local.https_protocol
    to_port     = 6443
    cidr_blocks = [local.cidr_all]
  }
  ingress {
    from_port   = -1
    protocol    = local.icmp_protocol
    to_port     = -1
    cidr_blocks = [local.cidr_all]
  }


  tags = {
    Name = "k8s_security_group"
  }
}

resource "aws_instance" "k8s_control_plane" {
  ami           = local.ubuntu_ami
  instance_type = local.instance_type

  associate_public_ip_address = true
  availability_zone           = local.subnet_az
  key_name                    = aws_key_pair.k8s_key_pair.key_name

  subnet_id              = aws_subnet.k8s_main.id
  private_ip             = "10.240.0.1${count.index}"
  vpc_security_group_ids = [aws_security_group.k8s_security_group.id]

  tags = {
    Name = "controller-${count.index}"
  }

  count = 3
}

resource "aws_instance" "k8s_worker_plane" {
  ami           = local.ubuntu_ami
  instance_type = local.instance_type

  associate_public_ip_address = true
  availability_zone           = local.subnet_az
  key_name                    = aws_key_pair.k8s_key_pair.key_name

  subnet_id              = aws_subnet.k8s_main.id
  private_ip             = local.workers[count.index]["private_ip"]
  vpc_security_group_ids = [aws_security_group.k8s_security_group.id]

  tags = {
    Name = "${local.worker_name}-${count.index}"
  }

  count = local.num_workers
}

locals {
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

output "k8s_worker_ips" {
  value = local.workers
}

output "k8s_workers" {
  value = [
    for k, v in aws_instance.k8s_worker_plane : {
      name : v.tags["Name"]
      public_ip : v.public_ip,
      private_ip : v.private_ip
    }
  ]
}
