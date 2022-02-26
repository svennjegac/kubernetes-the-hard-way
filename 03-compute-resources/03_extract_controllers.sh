#!/bin/zsh

terraform output -json | jq -r '.k8s_controllers.value | .[] | "\(.name) \(.private_ip) \(.public_ip)"' > 03_controllers.txt
mv 03_controllers.txt ../99_shared
