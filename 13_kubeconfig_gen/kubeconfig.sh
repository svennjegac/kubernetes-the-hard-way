#!/bin/zsh

set -e

secret_name=$(kubectl --namespace $namespace get sa $service_account -o jsonpath='{.secrets[0].name}')
ca=$(kubectl --namespace $namespace get secret/$secret_name -o jsonpath='{.data.ca\.crt}')
token=$(kubectl --namespace $namespace get secret/$secret_name -o jsonpath='{.data.token}' | base64 --decode)

echo "apiVersion: v1
kind: Config
clusters:
  - name: ${cluster_name}
    cluster:
      certificate-authority-data: ${ca}
      server: ${server}
contexts:
  - name: ${service_account}@${cluster_name}
    context:
      cluster: ${cluster_name}
      namespace: ${namespace}
      user: ${service_account}
users:
  - name: ${service_account}
    user:
      token: ${token}
current-context: ${service_account}@${cluster_name}
" > ${service_account}.kubeconfig
