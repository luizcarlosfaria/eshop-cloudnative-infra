#!/bin/bash

while getopts ui flag; do
    case "${flag}" in
    u) operation=delete ;;
    i) operation=apply ;;
    esac
done

operation=${operation:-apply}

# drop old cluster #################################################################

kubectl cluster-info

k3d cluster list

k3d cluster delete eshop

rm -R -f /docker/k3d/storage/**

if [ "$operation" = "apply" ]; then
  
    # Permissões #################################################################
    chmod -R u=rw,go=rw /docker/k3d/

    # create new cluster #################################################################

    k3d cluster create eshop \
        -p "80:80@loadbalancer" \
        -p "443:443@loadbalancer" \
        -p "30777-30797:30777-30797@loadbalancer" \
        --servers 1 \
        --volume /docker/k3d/storage:/var/lib/rancher/k3s/storage@all

    cat ~/.kube/config

fi


