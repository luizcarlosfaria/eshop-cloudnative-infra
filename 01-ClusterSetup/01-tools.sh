#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

echo "$(tput setaf 2)Instalando ferramentas...$(tput sgr0)"

# golang #################################################################
FILE=/usr/local/go/bin/go
FILE_NAME=go
if [ -f "$FILE" ]; then
    echo "$(tput setaf 2)$FILE_NAME está instalado!$(tput sgr0)"
    go version
else
    echo "$(tput setaf 2)Instalando $FILE_NAME...$(tput sgr0)"

    curl -L https://go.dev/dl/go1.18.2.linux-amd64.tar.gz -o ./go1.18.2.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
    rm ./go1.18.2.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo $PATH
fi

# cmctl #################################################################
FILE=/usr/local/bin/cmctl
FILE_NAME=cmctl
if [ -f "$FILE" ]; then
    echo "$(tput setaf 2)$FILE_NAME está instalado!$(tput sgr0)"
    cmctl version
else
    echo "$(tput setaf 2)Instalando $FILE_NAME...$(tput sgr0)"

    OS=$(go env GOOS)
    ARCH=$(go env GOARCH)
    curl -sSL -o cmctl.tar.gz https://github.com/cert-manager/cert-manager/releases/download/v1.7.2/cmctl-$OS-$ARCH.tar.gz
    tar xzf cmctl.tar.gz
    sudo mv cmctl /usr/local/bin
    rm ./cmctl.tar.gz ./LICENSES
fi

# krew #################################################################
FILE=$HOME/.krew/bin/kubectl-krew
FILE_NAME=kubectl-krew
if [ -f "$FILE" ]; then
    echo "$(tput setaf 2)$FILE_NAME está instalado!$(tput sgr0)"
    kubectl-krew version
else
    echo "$(tput setaf 2)Instalando $FILE_NAME...$(tput sgr0)"

    (
        set -x
        cd "$(mktemp -d)" &&
            OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
            ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
            KREW="krew-${OS}_${ARCH}" &&
            curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
            tar zxvf "${KREW}.tar.gz" &&
            ./"${KREW}" install krew
    )
    echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >>$HOME/.bashrc
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

fi

# kubectl-minio #################################################################
FILE=$HOME/.krew/bin/kubectl-minio
FILE_NAME=kubectl-minio
if [ -f "$FILE" ]; then
    echo "$(tput setaf 2)$FILE_NAME está instalado!$(tput sgr0)"
    kubectl-minio version
else
    echo "$(tput setaf 2)Instalando $FILE_NAME...$(tput sgr0)"

    kubectl krew update

    kubectl krew install minio

fi
