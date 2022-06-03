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

set echo off

echo "operation: $operation"

## v1 ------------
################################


kubectl ${operation} -f ./Phase1

## Aguardando setup do RabbitMQ

echo "$(tput setaf 2)Aguardando subida do cluster RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=ClusterAvailable rabbitmqclusters.rabbitmq.com rabbitmq

kubectl ${operation} -f ./Phase2

echo "$(tput setaf 2)Aguardando criação de vhosts do RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready vhosts.rabbitmq.com --all
 
echo "$(tput setaf 2)Aguardando criação de usuários do RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready users.rabbitmq.com --all
 
echo "$(tput setaf 2)Aguardando concessão das permissões no RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready permissions.rabbitmq.com --all

echo "$(tput setaf 2)Concluído!$(tput sgr0)"
echo ""

## Exbindo credenciais

echo "$(tput setaf 2)Dashboard---------------------------------------------------------$(tput sgr0)"

echo "https://$(kubectl get ingress gago-dashboard-ingress -n kubernetes-dashboard -o=jsonpath='{.spec.rules[].host}'):30777/"

kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user-token | cut -d " " -f1) | grep token:

echo ""
echo "$(tput setaf 2)PgAdmin---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress pgadmin-ingress -n eshop-resources -o=jsonpath='{.spec.rules[].host}')/"
echo "$(tput setaf 2)Usuario:$(tput sgr0) $(kubectl get secret pgadmin -n eshop-resources -o=jsonpath='{.data.pgadmin-username}' | base64 -d )"
echo "$(tput setaf 2)Senha:$(tput sgr0) $(kubectl get secret pgadmin -n eshop-resources -o=jsonpath='{.data.pgadmin-password}' | base64 -d )"
echo "$(tput setaf 2)Senha do usuário postgres:$(tput sgr0) $(kubectl get secret superuser-secret -n eshop-resources -o=jsonpath='{.data.password}' | base64 -d )"

echo ""
echo "$(tput setaf 2)RabbitMQ---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress rabbitmq-ingress -n eshop-resources -o=jsonpath='{.spec.rules[].host}')/"
echo "$(tput setaf 2)Usuario:$(tput sgr0) $(kubectl get -n eshop-resources secret rabbitmq-default-user  -o jsonpath="{.data.username}" | base64 -d)"
echo "$(tput setaf 2)Senha:$(tput sgr0) $(kubectl get -n eshop-resources secret rabbitmq-default-user  -o jsonpath="{.data.password}" | base64 -d)"

echo ""