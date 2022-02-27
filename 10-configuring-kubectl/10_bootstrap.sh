#!/bin/zsh

KUBERNETES_PUBLIC_ADDRESS=`cat ../99_shared/03_eip.txt`

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=../04-certificate-authority/ca/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials admin \
  --client-certificate=../04-certificate-authority/adminclientcert/admin.pem \
  --client-key=../04-certificate-authority/adminclientcert/admin-key.pem \

kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin

kubectl config use-context kubernetes-the-hard-way
