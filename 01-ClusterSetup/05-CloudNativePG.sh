#!/bin/bash

# cloudnative-pg operator #################################################################
echo "$(tput setaf 2)Implantando cloudnative-pg (operator de PostgreSQL)...$(tput sgr0)"

kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/releases/cnpg-1.15.0.yaml

kubectl get deploy -n cnpg-system cnpg-controller-manager
