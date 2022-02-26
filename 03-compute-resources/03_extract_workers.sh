#!/bin/zsh

terraform output -json | jq .k8s_worker_ips.value | jq -r '.[] | "\(.name) \(.private_ip)"' > 03_workers.txt
mv 03_workers.txt ../99_shared
