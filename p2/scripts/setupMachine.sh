#!/bin/bash

# set -x
set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"
BORDER="${CYAN}============================================${RESET}"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110" sh -

# apply the deployments

kubectl apply -f /vagrant/confs/app-one.yaml
kubectl apply -f /vagrant/confs/app-two.yaml
kubectl apply -f /vagrant/confs/app-three.yaml

echo -e "\n$BORDER"
echo -e "${GREEN}       🚀 Deployments and Service has been Applied 🚀${RESET}"
echo -e "$BORDER\n"

# apply Ingress

kubectl apply -f /vagrant/confs/ingress.yaml

echo -e "\n$BORDER"
echo -e "${GREEN}       🚀 Ingress has been Applied 🚀${RESET}"
echo -e "$BORDER\n"
