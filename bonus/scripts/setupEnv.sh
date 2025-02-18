#!/bin/sh

K3D_FIX_DNS=0 k3d cluster create --servers 2 --agents 2

if [ $? -ne 0 ]; then
  k3d cluster delete
  K3D_FIX_DNS=0 k3d cluster create --servers 2 --agents 2
fi

helm repo add gitlab http://charts.gitlab.io/

helm install my-gitlab gitlab/gitlab --version 8.8.2 --namespace gitlab --create-namespace --set certmanager-issuer.email=ymks9330@gmail.com -f "../confs/values.yaml"
