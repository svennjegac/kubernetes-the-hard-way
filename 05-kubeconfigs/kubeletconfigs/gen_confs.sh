#!/bin/zsh

KUBERNETES_PUBLIC_ADDRESS=`cat ../../99_shared/03_eip.txt`

while read line; do
  splits=("${(@s/ /)line}")
  instance=$splits[1]
  private_ip=$splits[2]
  public_ip=$splits[3]

  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../04-certificate-authority/ca/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-credentials system-node-${instance} \
    --client-certificate=../../04-certificate-authority/kubeletclientcert/${instance}.pem \
    --client-key=../../04-certificate-authority/kubeletclientcert/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system-node-${instance} \
    --kubeconfig=${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=${instance}.kubeconfig

done <./../../99_shared/03_workers.txt
