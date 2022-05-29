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

kubectl ${operation} -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"


kubectl ${operation} -f "https://github.com/rabbitmq/messaging-topology-operator/releases/latest/download/messaging-topology-operator-with-certmanager.yaml"