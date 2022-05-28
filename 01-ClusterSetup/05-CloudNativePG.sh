#!/bin/bash

# cloudnative-pg operator #################################################################
kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/releases/cnpg-1.15.0.yaml

kubectl get deploy -n cnpg-system cnpg-controller-manager
