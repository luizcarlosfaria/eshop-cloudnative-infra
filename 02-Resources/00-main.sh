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

## v1 ------------
################################

kubectl ${operation} -f ./Phase1

#kubectl scale -n minio-operator deployment minio-operator --replicas=1

## Aguardando setup do RabbitMQ

echo "$(tput setaf 2)Aguardando subida do cluster RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=ClusterAvailable rabbitmqclusters.rabbitmq.com rabbitmq

kubectl ${operation} -f ./Phase2

kubectl ${operation} -f ./Phase3


./01-wait.sh

./02-guide.sh