#!/bin/zsh

cd ca
sh gen_cert.sh
cd ..

cd adminclientcert
sh gen_cert.sh
cd ..

cd controllermanagerclientcert
sh gen_cert.sh
cd ..