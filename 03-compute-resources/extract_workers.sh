#!/bin/zsh

terraform output -json | jq .k8s_worker_ips.value | jq -r '.[] | "\(.name) \(.private_ip)"' > workers.txt
