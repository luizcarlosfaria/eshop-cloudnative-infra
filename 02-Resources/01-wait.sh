#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

################################
## v1 ------------

while getopts ui flag; do
    case "${flag}" in
    u) operation=delete ;;
    i) operation=apply ;;
    esac
done

operation=${operation:-apply}

set echo off

echo "operation: $operation"


echo "$(tput setaf 2)Aguardando criação de vhosts do RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready vhosts.rabbitmq.com --all
 
echo "$(tput setaf 2)Aguardando criação de usuários do RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready users.rabbitmq.com --all
 
echo "$(tput setaf 2)Aguardando concessão das permissões no RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready permissions.rabbitmq.com --all

echo "$(tput setaf 2)Aguardando minio operator...$(tput sgr0)"
kubectl -n minio-operator wait --timeout=5m --for=condition=Available deployment minio-operator

echo "$(tput setaf 2)Aguardando minio tenant...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m  statefulset/eshop-ss-0 --for jsonpath='{.status.readyReplicas}'=2

echo "$(tput setaf 2)Concluído!$(tput sgr0)"

