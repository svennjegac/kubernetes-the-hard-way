#!/bin/zsh

KUBERNETES_PUBLIC_ADDRESS=`cat ../../99_shared/03_eip.txt`

kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../../04-certificate-authority/ca/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

kubectl config set-credentials system:kube-proxy \
  --client-certificate=../../04-certificate-authority/kubeproxyclientcert/kube-proxy.pem \
  --client-key=../../04-certificate-authority/kubeproxyclientcert/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=system:kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
