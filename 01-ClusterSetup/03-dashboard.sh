#!/bin/bash

# dashboard #################################################################

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

# dashboard #################################################################

kubectl apply -f ./03.1-dashboard.accounts.yaml

kubectl apply -f ./03.2-dashboard.ingress.yaml

# bash alias #################################################################

cat ~/.bash_aliases | grep -v kdt= >~/.bash_aliases

cat <<EOF | tee ~/.bash_aliases
alias kdt='kubectl -n kubernetes-dashboard describe secret \$(kubectl -n kubernetes-dashboard get secret | grep admin-user-token | cut -d " " -f1)'
EOF

cat ~/.bash_aliases

