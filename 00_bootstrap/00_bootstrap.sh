#!/bin/zsh

set -e

cd ..

mkdir 99_shared

cd 03-compute-resources
sh 03_bootstrap.sh
cd ..

cd 04-certificate-authority
sh 04_bootstrap.sh
cd ..
