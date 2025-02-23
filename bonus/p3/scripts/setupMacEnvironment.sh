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

# log 1 "Installing dependencies ..."

# sudo pacman -Sy docker kubectl wget --noconfirm

# log 0 "dependencies has been installed"


# log 1 "start docker ..."

# sudo systemctl start docker.socket
# sudo systemctl start docker.service

# log 1 "enable docker on boot ..."

# sudo systemctl enable docker.socket
# sudo systemctl enable docker.service

# log 0 "docker has been configured"

# log 1 "Installing k3d ..."

# # Check if docker exists
# if ! command -v k3d &> /dev/null; then
#     wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# fi

# log 0 "k3d has been installed"

log 1 "create namespaces with kubectl ..."

kubectl apply -f ../confs/namespaces.yaml

log 0 "namespaces has been created"

log 1 "installing argoCD in cluster ..."

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

log 0 "argoCD has been installed inside the cluster in argocd namespace"


log 1 "apply the argocd application manifest ..."

kubectl apply -f ../confs/application.yaml

log 0 "argocd application manifest has been applied"

log 1 "waiting to get argocd credentials ..."

kubectl wait --for=condition=available --timeout=9000s deployment/argocd-server -n argocd

ARGOCD_PASS=$(kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep pass | awk '{print $2}' | base64 -d)

GREEN='\033[0;32m'
NC='\033[0m' # No Color

log 0 "${GREEN}ArgoCD and application ready to use${NC}"
echo ""
log 0 "  ➜  Local:\t${GREEN}http://localhost:9999/${NC}"
log 0 "  ➜  user:\t${GREEN}admin${NC}"
log 0 "  ➜  password:\t${GREEN}$ARGOCD_PASS${NC}"

kubectl port-forward -n argocd svc/argocd-server 9999:443