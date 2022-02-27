#!/bin/zsh

set -e

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

ssh -tt -i ../99_shared/03_k8s_ssh_key ubuntu@$public_ip <<EOF
kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns-1.8.yaml --kubeconfig admin.kubeconfig
exit
EOF
break

done <./../99_shared/03_controllers.txt
