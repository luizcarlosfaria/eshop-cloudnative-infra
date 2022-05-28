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

if [ "$operation" = "apply" ]; then

    ./01-tools.sh $1

    ./02-cluster-recreate.sh $1

    ./03-dashboard.sh $1

    ./04-namespaces.sh $1

    ./05-CloudNativePG.sh $1

    ./06-echo.sh $1

fi

if [ "$operation" = "delete" ]; then
    echo "operation=delete"

    ./02-cluster-recreate.sh $1
fi
