#!/bin/zsh

ssh-keygen -t rsa -b 4096 -C example@email.com -f /Users/svennjegac/Sven/private/src/kubernetes-the-hard-way/03-compute-resources/k8s_ssh_key
chmod 400 k8s_ssh_key.pub
