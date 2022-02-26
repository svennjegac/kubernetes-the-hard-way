#!/bin/zsh

set -e

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../99_shared/03_k8s_ssh_key installer.sh ubuntu@$public_ip:~/
ssh -tt -i ../99_shared/03_k8s_ssh_key ubuntu@$public_ip <<EOF
sudo sh installer.sh
exit
EOF

done <./../99_shared/03_controllers.txt

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../99_shared/03_k8s_ssh_key rbac_api_kubelet.sh ubuntu@$public_ip:~/
ssh -tt -i ../99_shared/03_k8s_ssh_key ubuntu@$public_ip <<EOF
sudo sh rbac_api_kubelet.sh
exit
EOF
break

done <./../99_shared/03_controllers.txt
