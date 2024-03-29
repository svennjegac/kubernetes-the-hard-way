#!/bin/zsh

echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ${service_account}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: ${service_account}
    namespace: ${namespace}" > role_binding.yaml

kubectl apply -f role_binding.yaml
rm role_binding.yaml
