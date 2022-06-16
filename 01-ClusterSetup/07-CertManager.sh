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

echo "operation: $operation"

echo "$(tput setaf 2)Implantando Cert Manager...$(tput sgr0)"
kubectl ${operation} -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml

if [ "$operation" = "apply" ]; then

cmctl check api --wait=5m

fi