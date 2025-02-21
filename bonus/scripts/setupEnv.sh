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

K3D_FIX_DNS=0 k3d cluster create -p "22:22@loadbalancer" -p "80:80@loadbalancer" \
    -p "8888:30100@loadbalancer" #? part 3 wil42 application port

# if [ $? -ne 0 ]; then
#   k3d cluster delete
#   K3D_FIX_DNS=0 k3d cluster create -p "22:22@loadbalancer" -p "80:80@loadbalancer"
# fi

helm repo add gitlab http://charts.gitlab.io/

helm install my-gitlab gitlab/gitlab --wait --version 8.8.2 --namespace gitlab --create-namespace --set certmanager-issuer.email=ymks9330@gmail.com \
    -f "../confs/values.yaml" \
    --timeout 600s


if [ $? -eq 0 ]; then
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color
  GITLAB_PASS=$(kubectl get secret -n gitlab my-gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo)

  log 0 "${GREEN}Gitlab deployed successfuly, you can access it with below url and credentials${NC}"
  echo ""
  log 0 "  ➜  Local:   ${GREEN}http://gitlab.localhost/${NC}"
  log 0 "  ➜  user: ${GREEN}root${NC}"
  log 0 "  ➜  password: ${GREEN}$GITLAB_PASS${NC}"
fi