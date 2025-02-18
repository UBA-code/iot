#!/bin/sh

K3D_FIX_DNS=0 k3d cluster create -p "22:32022@loadbalancer" -p "8888:80@loadbalancer"

if [ $? -ne 0 ]; then
  k3d cluster delete
  K3D_FIX_DNS=0 k3d cluster create -p "22:32022@loadbalancer" -p "8888:80@loadbalancer"
fi

helm repo add gitlab http://charts.gitlab.io/

helm install my-gitlab gitlab/gitlab --wait --version 8.8.2 --namespace gitlab --create-namespace --set certmanager-issuer.email=ymks9330@gmail.com \
    -f "../confs/values.yaml" \
    --timeout 600s \
    # -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
    # --set global.hosts.domain=localhost.nip.io \
    # --set global.hosts.externalIP=localhost

# kubectl port-forward -n gitlab svc/my-gitlab-webservice-default 1234:8181