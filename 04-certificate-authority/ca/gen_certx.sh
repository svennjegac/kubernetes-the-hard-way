#!/bin/zsh

if [ -f ca.csr ]; then
  rm ca.csr
fi

if [ -f ca.pem ]; then
  rm ca.pem
fi

if [ -f ca-key.pem ]; then
  rm ca-key.pem
fi
