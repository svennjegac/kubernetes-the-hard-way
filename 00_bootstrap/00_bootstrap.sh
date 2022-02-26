#!/bin/zsh

set -e

cd ..

mkdir 99_shared

cd 03-compute-resources
sh 03_bootstrap.sh
cd ..

cd 04-certificate-authority
zsh 04_bootstrap.sh
cd ..

cd 05-kubeconfigs
zsh 05_bootstrap.sh
cd ..