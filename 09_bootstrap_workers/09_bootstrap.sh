#!/bin/zsh

set -e

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../99_shared/03_k8s_ssh_key packager.sh ubuntu@$public_ip:~/
ssh -tt -i ../99_shared/03_k8s_ssh_key ubuntu@$public_ip <<EOF
sudo sh packager.sh
exit
EOF

done <./../99_shared/03_workers.txt

echo "waiting for software"
sleep 30

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../99_shared/03_k8s_ssh_key hostname.sh ubuntu@$public_ip:~/
ssh -tt -i ../99_shared/03_k8s_ssh_key ubuntu@$public_ip <<EOF
sudo sh hostname.sh
exit
EOF

done <./../99_shared/03_workers.txt

echo "done with hostnames"
sleep 10

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

done <./../99_shared/03_workers.txt
