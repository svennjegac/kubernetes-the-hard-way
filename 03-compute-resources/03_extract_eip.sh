#!/bin/zsh

set -e

terraform output -json | jq -r .k8s_eip.value > 03_eip.txt
mv 03_eip.txt ../99_shared
