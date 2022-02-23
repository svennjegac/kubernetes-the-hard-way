locals {
  ubuntu_ami    = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"
}

resource "aws_key_pair" "k8s_key_pair" {
  key_name   = "k8s_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDhC2Q65G1NyAGq5vueaLiYBS7eH2vnoHuf2hHVMWOT6hMFYhHePkVBjG4pWQqcX48fpX2t7ZChkFRfz3ZyMl72zAXmNQgD/JH0zXYvnmaL6YvtvJXng7LR0/r26c2GIgWaBn7pO9wSXSIM/ZBYY5tYC+p5MZj0Edb64vuV0fS3RYNidNTk09gzyT2q7hYLyOiUeBPnEhoOSMONblpRV/B+tgqT1f17V2va3RKMKWQVtptSpMq7rfr4XbXL9DAzeoWekQssG3xboPRMnBDH3QLGJZ07OzMtF6o8IiLTWbynNL61hWxikV5ubgaUbt50x9cRuL7Q05suzre4a8k2+TfqqZIdgcEc/XAbcGcFCsOwMm2O3XJGQ2Sl5pXPzbpjX6pDGR65uFmlyC5jui3c6i3/h7Tg6equFzmlO5rzIz16Bbeso3ytXgGaq1DBR0TfOwdFcqfe1jwUw2uMqOLxoNHsIOgF8RNDPYtL8Lac2Wrx7nwkXTG7oCbAFasbb7nXw0x1acAXi/bhKhUq2WO4S26lcbyWx73fukCsRaoXJp5emjTjBv5/hTsD5vDAxX9U2moiiz67FkrETooXIZpuTGsPKueJEy6AoEWzxsulrWR48cypAU5ZJ5qhBkGcuw4aG2sw9b947+i2YNv044NCPHI4UcOrgm8FJfNOhfS0uPIeaw== example@email.com"

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

  subnet_id       = aws_subnet.k8s_main.id
  private_ip      = "10.240.0.1${count.index}"
  vpc_security_group_ids = [aws_security_group.k8s_security_group.id]

  tags = {
    Name = "k8s_controller_${count.index}"
  }

  count = 3
}

resource "aws_instance" "k8s_worker_plane" {
  ami           = local.ubuntu_ami
  instance_type = local.instance_type

  associate_public_ip_address = true
  availability_zone           = local.subnet_az
  key_name                    = aws_key_pair.k8s_key_pair.key_name

  subnet_id       = aws_subnet.k8s_main.id
  private_ip      = "10.240.0.2${count.index}"
  vpc_security_group_ids = [aws_security_group.k8s_security_group.id]

  tags = {
    Name = "k8s_worker_${count.index}"
  }

  count = 3
}
