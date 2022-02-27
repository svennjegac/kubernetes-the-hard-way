resource "aws_vpc" "k8s_main" {
  cidr_block = local.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "k8s_vpc"
  }
}

resource "aws_subnet" "k8s_main" {
  vpc_id     = aws_vpc.k8s_main.id
  cidr_block = local.subnet_cidr

  availability_zone = local.subnet_az

  tags = {
    Name = "k8s_subnet"
  }
}

resource "aws_subnet" "k8s_fake" {
  vpc_id     = aws_vpc.k8s_main.id
  cidr_block = local.fake_subnet_cidr

  availability_zone = local.fake_subnet_az

  tags = {
    Name = "k8s_fake_subnet"
  }
}

resource "aws_internet_gateway" "k8s_main" {
  vpc_id = aws_vpc.k8s_main.id

  tags = {
    Name = "k8s_igw"
  }
}

resource "aws_route_table" "k8s_main" {
  vpc_id = aws_vpc.k8s_main.id

  route {
    cidr_block = local.cidr_all
    gateway_id = aws_internet_gateway.k8s_main.id
  }

  route {
    cidr_block  = local.pod_cidr_0
    instance_id = aws_instance.k8s_worker_plane[0].id
  }

  route {
    cidr_block  = local.pod_cidr_1
    instance_id = aws_instance.k8s_worker_plane[1].id
  }

  route {
    cidr_block  = local.pod_cidr_2
    instance_id = aws_instance.k8s_worker_plane[2].id
  }

  tags = {
    Name = "k8s_route_table"
  }
}

resource "aws_route_table" "k8s_fake" {
  vpc_id = aws_vpc.k8s_main.id

  route {
    cidr_block = local.cidr_all
    gateway_id = aws_internet_gateway.k8s_main.id
  }

  tags = {
    Name = "k8s_fake_route_table"
  }
}

resource "aws_route_table_association" "k8s_main" {
  route_table_id = aws_route_table.k8s_main.id
  subnet_id      = aws_subnet.k8s_main.id
}

resource "aws_route_table_association" "k8s_fake" {
  route_table_id = aws_route_table.k8s_fake.id
  subnet_id      = aws_subnet.k8s_fake.id
}

resource "aws_network_acl" "k8s_main" {
  vpc_id     = aws_vpc.k8s_main.id
  subnet_ids = [aws_subnet.k8s_main.id]

  // allow all egress
  egress {
    action     = "allow"
    from_port  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
    cidr_block = local.cidr_all
    icmp_code  = 0
    icmp_type  = 0
  }

  // TODO
  // allow all ingress
  ingress {
    action     = "allow"
    from_port  = 0
    protocol   = "-1"
    rule_no    = 99
    to_port    = 0
    cidr_block = local.cidr_all
    icmp_code  = 0
    icmp_type  = 0
  }

  // allow vpc subnets
  ingress {
    action     = "allow"
    from_port  = 0
    protocol   = -1
    rule_no    = 100
    to_port    = 0
    cidr_block = local.vpc_cidr
    icmp_code  = 0
    icmp_type  = 0
  }
  // allow SSH, HTTPS v1 & v2, ICMP outside
  ingress {
    action     = "allow"
    from_port  = 22
    protocol   = local.ssh_protocol
    rule_no    = 200
    to_port    = 22
    cidr_block = local.cidr_all
    icmp_code  = 0
    icmp_type  = 0
  }
  ingress {
    action     = "allow"
    from_port  = 443
    protocol   = local.https_protocol
    rule_no    = 300
    to_port    = 443
    cidr_block = local.cidr_all
    icmp_code  = 0
    icmp_type  = 0
  }
  ingress {
    action     = "allow"
    from_port  = 6443
    protocol   = local.https_protocol
    rule_no    = 400
    to_port    = 6443
    cidr_block = local.cidr_all
    icmp_code  = 0
    icmp_type  = 0
  }
  ingress {
    action     = "allow"
    from_port  = 0
    protocol   = local.icmp_protocol
    rule_no    = 500
    to_port    = 0
    cidr_block = local.cidr_all
    icmp_code  = -1
    icmp_type  = -1
  }

  tags = {
    Name = "k8s_nacl"
  }
}
