#!/bin/zsh

KUBERNETES_PUBLIC_ADDRESS=`cat ../../99_shared/03_eip.txt`
KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local

cfssl gencert \
  -ca=../ca/ca.pem \
  -ca-key=../ca/ca-key.pem \
  -config=../ca/ca-config.json \
  -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes
