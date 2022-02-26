#!/bin/zsh

cd ..

cd 03-compute-resources
sh 03_bootstrapx.sh
cd ..

cd 04-certificate-authority
sh 04_bootstrapx.sh
cd ..

rm -rf 99_shared
