#!/bin/zsh

cd ..

cd 03-compute-resources
sh 03_bootstrap.sh
cd ..

cd 04-certificate-authority
sh 04_bootstrap.sh
cd ..
