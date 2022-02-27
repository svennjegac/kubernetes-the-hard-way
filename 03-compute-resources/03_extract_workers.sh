#!/bin/zsh

set -e

terraform output -json | jq -r '.k8s_workers.value | .[] | "\(.name) \(.private_ip) \(.public_ip) \(.private_dns)"' > 03_workers.txt
mv 03_workers.txt ../99_shared
