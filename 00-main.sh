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

chmod -R +x ./**/*.sh


if [ "$operation" = "apply" ]; then

    cd ./01-ClusterSetup/

    ./00-main.sh $1

    sleep 10

    cd ../02-Resources/

    ./00-main.sh $1

fi

if [ "$operation" = "delete" ]; then

    cd ./01-ClusterSetup/

    ./00-main.sh -u
fi
