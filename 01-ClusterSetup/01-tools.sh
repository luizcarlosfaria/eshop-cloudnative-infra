#!/bin/bash

echo "$(tput setaf 2)Instalando ferramentas...$(tput sgr0)"

# kubectl #################################################################
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#rm ./kubectl

# kompose #################################################################

#curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.1/kompose-linux-amd64 -o kompose
#sudo install -o root -g root -m 0755 kompose /usr/local/bin/kompose
#rm ./kompose


# go #################################################################
#curl -L https://go.dev/dl/go1.18.2.linux-amd64.tar.gz -o ./go1.18.2.linux-amd64.tar.gz
#rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
#rm ./go1.18.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
#echo $PATH
go version

# cmctl #################################################################
#OS=$(go env GOOS); ARCH=$(go env GOARCH); curl -sSL -o cmctl.tar.gz https://github.com/cert-manager/cert-manager/releases/download/v1.7.2/cmctl-$OS-$ARCH.tar.gz
#tar xzf cmctl.tar.gz
#sudo mv cmctl /usr/local/bin
#rm ./cmctl.tar.gz ./LICENSES



