#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

################################
## v1 ------------

set echo off

## v1 ------------
################################

kubectl apply -f ./00

kubectl apply -f ./01

#kubectl scale -n minio-operator deployment minio-operator --replicas=1

## Aguardando setup do RabbitMQ

echo "$(tput setaf 2)Aguardando subida do cluster RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=ClusterAvailable rabbitmqclusters.rabbitmq.com rabbitmq

echo "$(tput setaf 2)Aguardando subida do cluster Postgres...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=jsonpath='{.status.readyInstances}'=3 clusters.postgresql.cnpg.io eshop-postgres-cluster

kubectl apply -f ./02

#kubectl apply -f ./03

echo "$(tput setaf 2)Aguardando criação de vhosts do RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready vhosts.rabbitmq.com --all

echo "$(tput setaf 2)Aguardando criação de usuários do RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready users.rabbitmq.com --all

echo "$(tput setaf 2)Aguardando concessão das permissões no RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=Ready permissions.rabbitmq.com --all

echo "$(tput setaf 2)Aguardando minio operator...$(tput sgr0)"
kubectl -n minio-operator wait --timeout=5m --for=condition=Available deployment minio-operator

echo "$(tput setaf 2)Aguardando minio tenant...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m statefulset/eshop-ss-0 --for jsonpath='{.status.readyReplicas}'=2

echo "$(tput setaf 2)Concluído!$(tput sgr0)"

## Exbindo credenciais
echo ""
echo "$(tput setaf 2)Dashboard ---------------------------------------------------------$(tput sgr0)"
echo "https://188.40.114.31:30777/"
echo "$(tput setaf 1) $(kubectl -n kubernetes-dashboard create token admin-user) $(tput sgr0)"

echo ""
echo "$(tput setaf 2)Minio ---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress gago-minio-ingress -n minio-operator -o=jsonpath='{.spec.rules[].host}')/"
#echo "$(tput setaf 1) $(kubectl minio proxy -n minio-operator | grep JWT) $(tput sgr0)"
echo "$(tput setaf 2)accesskey:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-creds-secret -o jsonpath="{.data.accesskey}" | base64 -d)"
echo "$(tput setaf 2)secretkey:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-creds-secret -o jsonpath="{.data.secretkey}" | base64 -d)"
echo "$(tput setaf 2)CONSOLE_ACCESS_KEY:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-user-1 -o jsonpath="{.data.CONSOLE_ACCESS_KEY}" | base64 -d)"
echo "$(tput setaf 2)CONSOLE_SECRET_KEY:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-user-1 -o jsonpath="{.data.CONSOLE_SECRET_KEY}" | base64 -d)"

echo ""
echo "$(tput setaf 2)PgAdmin ---------------------------------------------------------$(tput sgr0)"
echo "http://188.40.114.31:30781/"
echo "$(tput setaf 2)Usuario:$(tput sgr0) $(kubectl get secret pgadmin -n eshop-resources -o=jsonpath='{.data.pgadmin-username}' | base64 -d)"
echo "$(tput setaf 2)Senha:$(tput sgr0) $(kubectl get secret pgadmin -n eshop-resources -o=jsonpath='{.data.pgadmin-password}' | base64 -d)"
echo "$(tput setaf 2)Senha do usuário postgres:$(tput sgr0) $(kubectl get secret superuser-secret -n eshop-resources -o=jsonpath='{.data.password}' | base64 -d)"

echo ""
echo "$(tput setaf 2)RabbitMQ ---------------------------------------------------------$(tput sgr0)"
echo "http://188.40.114.31:30779/"
echo "$(tput setaf 2)Usuario:$(tput sgr0) $(kubectl get -n eshop-resources secret rabbitmq-secret--admin -o jsonpath="{.data.username}" | base64 -d)"
echo "$(tput setaf 2)Senha:$(tput sgr0) $(kubectl get -n eshop-resources secret rabbitmq-secret--admin -o jsonpath="{.data.password}" | base64 -d)"

echo ""
echo ""
echo "Execute"
echo ""
echo "curl -v  http://localhost/echo1?a=1 -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{}'"
echo ""
echo "e"
echo ""
echo "curl -v  http://localhost/echo2?a=1 -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{}'"
echo ""
echo "para validar o ambiente"
