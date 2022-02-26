output "k8s_eip" {
  value = aws_eip.k8s_main.public_ip
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

output "k8s_controllers" {
  value = [
    for k, v in aws_instance.k8s_control_plane : {
      name : v.tags["Name"]
      public_ip : v.public_ip,
      private_ip : v.private_ip
    }
  ]
}
