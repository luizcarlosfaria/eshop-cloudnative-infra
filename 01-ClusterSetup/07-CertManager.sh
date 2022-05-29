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

kubectl ${operation} -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml

if [ "$operation" = "apply" ]; then

cmctl check api --wait=3m

fi