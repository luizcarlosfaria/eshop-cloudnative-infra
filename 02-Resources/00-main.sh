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

kubectl apply -f ./01

#kubectl scale -n minio-operator deployment minio-operator --replicas=1

## Aguardando setup do RabbitMQ

echo "$(tput setaf 2)Aguardando subida do cluster RabbitMQ...$(tput sgr0)"
kubectl -n eshop-resources wait --timeout=5m --for=condition=ClusterAvailable rabbitmqclusters.rabbitmq.com rabbitmq

echo "$(tput setaf 2)Aguardando subida do cluster Postgres...$(tput sgr0)"
#kubectl -n eshop-resources wait --timeout=5m --for=condition=ClusterAvailable rabbitmqclusters.rabbitmq.com eshop-postgres-cluster

kubectl apply -f ./02

#kubectl apply -f ./03

./01-wait.sh

./02-guide.sh
