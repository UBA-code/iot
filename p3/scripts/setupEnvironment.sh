#!/bin/sh

log() {
    local status=$1
    shift
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Define colors
    local reset="\033[0m"
    local green="\033[0;32m"  # Success
    local blue="\033[0;34m"   # Info
    local yellow="\033[0;33m" # Warning
    local red="\033[0;31m"    # Error

    # Choose color based on status
    local color=$reset
    case $status in
        0) color=$green ;;  # Success
        1) color=$blue ;;   # Info
        2) color=$yellow ;; # Warning
        3) color=$red ;;    # Error
    esac

    # Print log message with color
    echo -e "${color}${timestamp} - $*${reset}"
}

log 1 "Installing dependencies ..."

sudo pacman -Sy docker kubectl wget --noconfirm

log 0 "dependencies has been installed"


log 1 "start docker ..."

sudo systemctl start docker.socket
sudo systemctl start docker.service

log 1 "enable docker on boot ..."

sudo systemctl enable docker.socket
sudo systemctl enable docker.service

log 0 "docker has been configured"

log 1 "Installing k3d ..."

wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

log 0 "k3d has been installed"

log 1 "creating cluster ..."

k3d cluster create -p "8888:8888@loadbalancer" -p "8080:443@loadbalancer"
if [ $? -ne 0 ]; then
    k3d cluster delete
    k3d cluster create -p "8888:8888@loadbalancer" -p "8080:443@loadbalancer"
fi

log 0 "cluster has been created"

log 1 "create namespaces with kubectl ..."

kubectl apply -f ../confs/namespaces.yaml

log 0 "namespaces has been created"

log 1 "installing argoCD in cluster ..."

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

log 0 "argoCD has been installed inside the cluster in argocd namespace"


log 1 "apply the argocd application manifest ..."

kubectl apply -f ../confs/application.yaml

log 0 "argocd application manifest has been applied"
