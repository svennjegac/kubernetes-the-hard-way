resource "aws_eip" "k8s_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.k8s_main]

  tags = {
    Name = "k8s_eip"
  }
}