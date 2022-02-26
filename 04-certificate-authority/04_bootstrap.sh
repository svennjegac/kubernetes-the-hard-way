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

cd kubeletclientcert
zsh gen_cert.sh
cd ..

cd kubeproxyclientcert
sh gen_cert.sh
cd ..

cd kubernetesapiservercert
sh gen_cert.sh
cd ..

cd schedulerclientcert
sh gen_cert.sh
cd ..

cd serviceaccoutnkeypair
sh gen_cert.sh
cd ..

cd xx-distribute
zsh distribute.sh
cd ..

cd ..
