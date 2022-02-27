#!/bin/zsh

export WHNAME=`cat aws_dns.txt`
export WORKER_HOSTNAME=${WHNAME}

sudo sed -i -e "s/127.0.0.1 localhost/127.0.0.1 localhost persistent-hostname/" /etc/hosts
sudo cat /etc/hosts
sudo hostnamectl set-hostname $WORKER_HOSTNAME

sudo hostname
