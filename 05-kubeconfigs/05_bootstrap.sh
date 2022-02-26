#!/bin/zsh

cd admin
sh gen_confs.sh
cd ..

cd kubecontrollmanager
sh gen_confs.sh
cd ..

cd kubeletconfigs
zsh gen_confs.sh
cd ..

cd kubeproxyconfigs
sh gen_confs.sh
cd ..

cd kubescheduler
sh gen_confs.sh
cd ..

cd xx-distribute
zsh distribute.sh
cd ..

cd ..