#!/bin/bash

################################
## v1 ------------

while getopts ui flag; do
    case "${flag}" in
    u) operation=delete ;;
    i) operation=apply ;;
    esac
done

operation=${operation:-apply}

echo "operation: $operation"

## v1 ------------
################################


kubectl ${operation} -f ./Phase1


echo "$(tput setaf 2)Aguardando subida do cluster RabbitMQ$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=ClusterAvailable rabbitmqclusters.rabbitmq.com rabbitmq

kubectl ${operation} -f ./Phase2

echo "$(tput setaf 2)Aguardando criação de vhosts do RabbitMQ$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready vhosts.rabbitmq.com --all

 
echo "$(tput setaf 2)Aguardando criação de usuários do RabbitMQ$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready users.rabbitmq.com --all

 
echo "$(tput setaf 2)Aguardando concessão das permissões no RabbitMQ$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready permissions.rabbitmq.com --all

