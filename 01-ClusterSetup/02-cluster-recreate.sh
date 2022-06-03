#!/bin/bash

while getopts ui flag; do
    case "${flag}" in
    u) operation=delete ;;
    i) operation=apply ;;
    esac
done

operation=${operation:-apply}

# drop old cluster #################################################################

echo "$(tput setaf 2)Obtendo informações do cluster antigo...$(tput sgr0)"
kubectl cluster-info
k3d cluster list

echo "$(tput setaf 2)Deletando o cluster antigo...$(tput sgr0)"
k3d cluster delete eshop

echo "$(tput setaf 2)Removendo arquivos antigos do disco...$(tput sgr0)"
rm -R -f /docker/k3d/storage/**

if [ "$operation" = "apply" ]; then

    # Permissões #################################################################
    echo "$(tput setaf 2)Reestabelecendo permissões no disco...$(tput sgr0)"
    chmod -R u=rw,go=rw /docker/k3d/

    # create new cluster #################################################################
    echo "$(tput setaf 2)Criando um novo cluster...$(tput sgr0)"
    k3d cluster create eshop \
        -p "80:80@loadbalancer" \
        -p "443:443@loadbalancer" \
        -p "30777-30797:30777-30797@loadbalancer" \
        --servers 1 \
        --volume /docker/k3d/storage:/var/lib/rancher/k3s/storage@all

    cat ~/.kube/config

fi


