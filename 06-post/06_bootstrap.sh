#!/bin/zsh

set -e

while read line; do
echo -n $line > load_balancer.txt
done <./../99_shared/03_eip.txt

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

echo -n $instance > hostname.txt
echo -n $private_ip > internal_ip.txt
echo -n $public_ip > public_ip.txt
scp -i ../99_shared/03_k8s_ssh_key hostname.txt load_balancer.txt internal_ip.txt public_ip.txt ubuntu@$public_ip:~/
rm hostname.txt
rm internal_ip.txt
rm public_ip.txt

done <./../99_shared/03_controllers.txt

rm load_balancer.txt

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]
private_dns=$splits[4]

if [[ $instance == "worker-0" ]]; then
  echo -n "10.200.0.0/24" > pod_cidr.txt
elif [[ $instance == "worker-1" ]]; then
  echo -n "10.200.1.0/24" > pod_cidr.txt
else
  echo -n "10.200.2.0/24" > pod_cidr.txt
fi

echo -n $instance > hostname.txt
echo -n $private_dns > aws_dns.txt
scp -i ../99_shared/03_k8s_ssh_key pod_cidr.txt hostname.txt aws_dns.txt ubuntu@$public_ip:~/
rm pod_cidr.txt
rm hostname.txt
rm aws_dns.txt

done <./../99_shared/03_workers.txt
