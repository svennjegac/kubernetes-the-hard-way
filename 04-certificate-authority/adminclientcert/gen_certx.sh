#!/bin/zsh

if [ -f admin.csr ]; then
  rm admin.csr
fi

if [ -f admin.pem ]; then
  rm admin.pem
fi

if [ -f admin-key.pem ]; then
  rm admin-key.pem
fi
