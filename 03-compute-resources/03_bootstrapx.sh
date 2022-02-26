#!/bin/zsh

terraform destroy -auto-approve

if [ -f 03_k8s_ssh_key ]; then
  rm 03_k8s_ssh_key
fi

if [ -f 03_k8s_ssh_key.pub ]; then
  chmod 777 03_k8s_ssh_key.pub
  rm 03_k8s_ssh_key.pub
fi
