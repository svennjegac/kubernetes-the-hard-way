#!/bin/zsh

#!/bin/zsh

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

ssh-keyscan -H $public_ip >> ~/.ssh/known_hosts

scp -i ../../99_shared/03_k8s_ssh_key \
  ../ca/ca.pem \
  ../kubeletclientcert/${instance}-key.pem \
  ../kubeletclientcert/${instance}.pem \
  ubuntu@$public_ip:~/

done <./../../99_shared/03_workers.txt
