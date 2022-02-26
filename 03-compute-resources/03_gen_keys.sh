#!/bin/zsh

if [ -f 03_k8s_ssh_key ]; then
  chmod 777 03_k8s_ssh_key
  rm 03_k8s_ssh_key
fi

if [ -f 03_k8s_ssh_key.pub ]; then
  chmod 777 03_k8s_ssh_key.pub
  rm 03_k8s_ssh_key.pub
fi

ssh-keygen -t rsa -b 4096 -C example@email.com -f /Users/svennjegac/Sven/private/src/kubernetes-the-hard-way/03-compute-resources/03_k8s_ssh_key -q -N ""
chmod 400 03_k8s_ssh_key.pub

export TF_VAR_k8s_ssh_public_key=`cat 03_k8s_ssh_key.pub`
mv 03_k8s_ssh_key ../99_shared
