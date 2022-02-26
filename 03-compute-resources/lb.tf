resource "aws_eip" "k8s_main" {
  vpc        = true
  depends_on = [aws_internet_gateway.k8s_main]

  tags = {
    Name = "k8s_eip"
  }
}

resource "aws_lb_target_group" "k8s_main" {
  name                               = "k8s-target-group"
  lambda_multi_value_headers_enabled = false
  port                               = 6443
  preserve_client_ip                 = true
  protocol                           = "TCP"
  vpc_id                             = aws_vpc.k8s_main.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200-399"
    path                = "/healthz"
    port                = "traffic-port"
    protocol            = "HTTPS"
    timeout             = 10
    unhealthy_threshold = 3
  }

  stickiness {
    cookie_duration = 0
    enabled         = false
    type            = "source_ip"
  }
}

resource "aws_lb_target_group_attachment" "k8s_main" {
  target_group_arn = aws_lb_target_group.k8s_main.arn
  target_id        = aws_instance.k8s_control_plane[count.index].id
  count            = 3
}

resource "aws_lb" "k8s_main" {
  name               = "k8s-lb"
  load_balancer_type = "network"
  internal           = false
  ip_address_type    = "ipv4"

  subnet_mapping {
    subnet_id = aws_subnet.k8s_fake.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.k8s_main.id
    allocation_id = aws_eip.k8s_main.id
  }
}

resource "aws_lb_listener" "k8s_main" {
  load_balancer_arn = aws_lb.k8s_main.arn
  port              = 6443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.k8s_main.arn
  }
}
