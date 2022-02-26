#!/bin/zsh

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../../99_shared/03_k8s_ssh_key \
  ../admin/admin.kubeconfig \
  ../kubecontrollmanager/kube-controller-manager.kubeconfig \
  ../kubescheduler/kube-scheduler.kubeconfig \
  ubuntu@$public_ip:~/

done <./../../99_shared/03_controllers.txt
