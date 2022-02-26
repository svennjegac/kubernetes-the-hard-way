#!/bin/zsh



ssh

wget -q --show-progress --https-only --timestamping "https://github.com/etcd-io/etcd/releases/download/v3.4.15/etcd-v3.4.15-linux-amd64.tar.gz"

export INTERNAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

export ETCD_NAME=`cat hostname.txt`