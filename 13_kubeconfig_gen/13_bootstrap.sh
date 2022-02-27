#!/bin/zsh

set -e

export service_account="sven.njegac"
export namespace="kube-system"
export cluster_name=kthw
export server=https://3.71.237.203:6443

zsh service_account.sh
zsh role_binding.sh
zsh kubeconfig.sh
