#!/bin/zsh

set -e

cd ..

mkdir 99_shared

cd 03-compute-resources
sh 03_bootstrap.sh
cd ..

echo "waiting ec2s"
sleep 10

cd 04-certificate-authority
zsh 04_bootstrap.sh
cd ..

cd 05-kubeconfigs
zsh 05_bootstrap.sh
cd ..

cd 06-data-encryption-keys
zsh 06_bootstrap.sh
cd ..

cd 06-post
zsh 06_bootstrap.sh
cd ..

cd 07-bootstrap-etcd
zsh 07_bootstrap.sh
cd ..

cd 08_bootstrap-controllers
zsh 08_bootstrap.sh
cd ..

cd 09_bootstrap_workers
zsh 09_bootstrap.sh
cd ..
