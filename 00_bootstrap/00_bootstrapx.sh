#!/bin/zsh

cd ..

cd 03-compute-resources
sh 03_bootstrapx.sh
cd ..

cd 04-certificate-authority
sh 04_bootstrapx.sh
cd ..

cd 05-kubeconfigs
zsh 05_bootstrapx.sh
cd ..

cd 06-data-encryption-keys
zsh 06_bootstrapx.sh
cd ..

rm -rf 99_shared
