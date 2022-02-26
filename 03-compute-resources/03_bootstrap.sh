#!/bin/zsh

source 03_ssh_keygen.sh

echo "exported var"
echo $TF_VAR_k8s_ssh_public_key

terraform apply -auto-approve

sh 03_extract_workers.sh
sh 03_extract_controllers.sh
sh 03_extract_eip.sh
