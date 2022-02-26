#!/bin/zsh

set -e

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../99_shared/03_k8s_ssh_key etcd_service_maker.sh ubuntu@$public_ip:~/

done <./../99_shared/03_controllers.txt
