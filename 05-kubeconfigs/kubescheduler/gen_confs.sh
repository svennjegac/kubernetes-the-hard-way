#!/bin/zsh

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=../../04-certificate-authority/ca/ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
  --client-certificate=../../04-certificate-authority/schedulerclientcert/kube-scheduler.pem \
  --client-key=../../04-certificate-authority/schedulerclientcert/kube-scheduler-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-scheduler.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=system:kube-scheduler \
  --kubeconfig=kube-scheduler.kubeconfig

kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
