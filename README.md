# Inception-of-Things (IoT)

This repository contains the implementation of the Inception-of-Things project, a system administration exercise focused on Kubernetes, K3s, and K3d technologies.

## Project Overview

The project is divided into three main parts, each focusing on different aspects of Kubernetes deployment:

1. **Part 1: K3s and Vagrant** - Setting up virtual machines with K3s in controller and agent modes
2. **Part 2: K3s and Three Applications** - Deploying multiple web applications with Ingress routing
3. **Part 3: K3d and Argo CD** - Implementing continuous integration using Argo CD

## Repository Structure

```
.
├── p1
│   └── Vagrantfile                # Vagrant configuration for Part 1
│
├── p2
│   ├── Vagrantfile                # Vagrant configuration for Part 2
│   ├── confs
│   │   ├── app-one.yaml           # Kubernetes manifest for application 1
│   │   ├── app-two.yaml           # Kubernetes manifest for application 2
│   │   ├── app-three.yaml         # Kubernetes manifest for application 3
│   │   └── ingress.yaml           # Ingress configuration
│   └── scripts
│       └── setupMachine.sh        # Setup script for Part 2
│
├── p3
│   ├── confs
│   │   ├── application.yaml       # Argo CD application configuration
│   │   └── namespaces.yaml        # Namespace definitions
│   └── scripts
│       └── setupEnvironment.sh    # Environment setup script for Part 3
│
└── bonus
    ├── confs
    │   └── values.yaml            # Configuration values for bonus part
    ├── p3
    │   ├── confs
    │   │   ├── application.yaml   # Argo CD application configuration for bonus
    │   │   └── namespaces.yaml    # Namespace definitions for bonus
    │   └── scripts
    │       └── setupEnvironment.sh # Environment setup script
    └── scripts
        └── setupEnv.sh            # Main setup script for bonus part
```

## Part 1: K3s and Vagrant

This part sets up two virtual machines using Vagrant:
- Server node (controller mode)
- Worker node (agent mode)

The machines are configured with specific IPs and hostnames, and K3s is installed in the appropriate mode on each.

### Usage

```bash
cd p1
vagrant up
```

## Part 2: K3s and Three Applications

This part deploys three web applications on a K3s instance and configures Ingress routing to access them based on the HOST header:
- app1.com → Application 1
- app2.com → Application 2 (with 3 replicas)
- Default → Application 3

### Usage

```bash
cd p2
vagrant up
```

To test:
```bash
curl -H "Host: app1.com" 192.168.56.110
curl -H "Host: app2.com" 192.168.56.110
curl 192.168.56.110
```

## Part 3: K3d and Argo CD

This part implements a continuous integration setup using K3d and Argo CD:
- Creates two namespaces: `argocd` and `dev`
- Deploys an application in the `dev` namespace using Argo CD
- Configures automatic deployment from a GitHub repository

### Usage

```bash
cd p3
./scripts/setupEnvironment.sh
```

## Bonus: Gitlab Integration

The bonus part adds Gitlab to the Part 3 setup:
- Runs Gitlab locally in a dedicated namespace
- Integrates Gitlab with the K3d cluster
- Configures the CI/CD pipeline to work with local Gitlab

### Usage

```bash
cd bonus
./scripts/setupEnv.sh
```

## Requirements

- Vagrant
- VirtualBox or another compatible provider
- Internet connection for downloading images and packages
- Git
- Docker (for Part 3 and Bonus)

## License

This project is part of a learning curriculum and is shared for educational purposes.
