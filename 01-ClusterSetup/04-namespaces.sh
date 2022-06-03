#!/bin/bash

# dashboard #################################################################


echo "$(tput setaf 2)Criando namespaces de projeto...$(tput sgr0)"
kubectl apply -f ./04-namespaces.yaml
