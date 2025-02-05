#!/bin/sh

sudo -i

pacman -Sy

pacman install docker -y

systemctl start docker.socket
systemctl start docker.service

systemct enable docker.socket
systemct enable docker.service

wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
 