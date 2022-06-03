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

chmod -R +x ../**/*.sh

## v1 ------------
################################

if [ "$operation" = "apply" ]; then

    ./01-tools.sh $1

    ./02-cluster-recreate.sh $1

    ./03-dashboard.sh $1

    ./04-namespaces.sh $1

    ./05-CloudNativePG.sh $1

    ./06-echo.sh $1

    ./07-CertManager.sh $1

    ./08-RabbitMQ-Operator.sh $1

fi

if [ "$operation" = "delete" ]; then

    ./02-cluster-recreate.sh $1
fi


