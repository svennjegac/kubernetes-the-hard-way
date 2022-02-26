#!/bin/zsh

set -e

zsh 07_prepare_hosts.sh

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

ssh -tt -i ../99_shared/03_k8s_ssh_key ubuntu@$public_ip <<EOF
wget -q --show-progress --https-only --timestamping "https://github.com/etcd-io/etcd/releases/download/v3.4.15/etcd-v3.4.15-linux-amd64.tar.gz"
tar -xf etcd-v3.4.15-linux-amd64.tar.gz
sudo mv etcd-v3.4.15-linux-amd64/etcd* /usr/local/bin/
sudo mkdir -p /etc/etcd /var/lib/etcd
sudo chmod 700 /var/lib/etcd
sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/
sudo sh etcd_service_maker.sh
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd &
exit
EOF

done <./../99_shared/03_controllers.txt
