#!/bin/zsh

terraform output -json | jq -r '.k8s_workers.value | .[] | "\(.name) \(.private_ip) \(.public_ip)"' > 03_workers.txt
mv 03_workers.txt ../99_shared
