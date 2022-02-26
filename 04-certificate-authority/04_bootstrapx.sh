#!/bin/zsh

cd ca
sh gen_certx.sh
cd ..

cd adminclientcert
sh gen_certx.sh
cd ..

cd controllermanagerclientcert
sh gen_certx.sh
cd ..

cd kubeletclientcert
sh gen_certx.sh
cd ..

cd kubeproxyclientcert
sh gen_certx.sh
cd ..

cd kubernetesapiservercert
sh gen_certx.sh
cd ..

cd schedulerclientcert
sh gen_certx.sh
cd ..

cd serviceaccoutnkeypair
sh gen_certx.sh
cd ..

