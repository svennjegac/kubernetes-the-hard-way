#!/bin/zsh

set -e

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

echo -n $instance > hostname.txt
scp -i ../99_shared/03_k8s_ssh_key hostname.txt ubuntu@$public_ip:~/
rm hostname.txt

done <./../99_shared/03_controllers.txt
