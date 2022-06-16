#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

################################

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

################################

if [ "$operation" = "apply" ]; then

    ./01-tools.sh -i

    ./02-cluster-recreate.sh -i

    ./03-dashboard.sh -i

    ./04-namespaces.sh -i

    ./05-CloudNativePG.sh -i

    ./06-echo.sh -i

    ./07-CertManager.sh -i

    ./08-RabbitMQ-Operator.sh -i

    ./09-Minio.sh -i

fi

if [ "$operation" = "delete" ]; then

    ./02-cluster-recreate.sh -u
fi


