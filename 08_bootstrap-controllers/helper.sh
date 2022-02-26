#!/bin/zsh

curl --cacert /Users/svennjegac/Sven/private/src/kubernetes-the-hard-way/04-certificate-authority/ca/ca.pem https:/18.193.151.195:6443/version
curl --cacert /Users/svennjegac/Sven/private/src/kubernetes-the-hard-way/04-certificate-authority/ca/ca.pem https:/18.193.151.195:6443/healthz