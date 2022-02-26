#!/bin/zsh

cd ca
sh gen_certx.sh
cd ..

cd adminclientcert
sh gen_certx.sh
cd ..
