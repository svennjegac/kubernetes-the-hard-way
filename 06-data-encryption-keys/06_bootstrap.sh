#!/bin/zsh

set -e

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
echo $ENCRYPTION_KEY

cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

scp -i ../99_shared/03_k8s_ssh_key encryption-config.yaml ubuntu@$public_ip:~/

done <./../99_shared/03_controllers.txt
