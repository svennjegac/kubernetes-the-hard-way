#!/bin/zsh

while read line; do
splits=("${(@s/ /)line}")
instance=$splits[1]
private_ip=$splits[2]
public_ip=$splits[3]

cat > ${instance}-csr.json <<EOF
{
  "CN": "system-node-${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "DE",
      "L": "Frankfurt",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Hesse"
    }
  ]
}
EOF

cfssl gencert \
  -ca=../ca/ca.pem \
  -ca-key=../ca/ca-key.pem \
  -config=../ca/ca-config.json \
  -hostname=${instance},${public_ip},${private_ip} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}
done <./../../99_shared/03_workers.txt
