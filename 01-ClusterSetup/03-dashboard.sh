#!/bin/bash

# dashboard #################################################################

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

# dashboard #################################################################

kubectl apply -f ./03.1-dashboard.accounts.yaml

kubectl apply -f ./03.2-dashboard.ingress.yaml

# bash alias #################################################################

cat ~/.bash_aliases | grep -v dash_set | grep -v dash_print >~/.bash_aliases

cat <<EOF | tee ~/.bash_aliases
alias dash_set_token='token=$(kubectl -n kubernetes-dashboard get secret | grep admin-user-token | cut -d " " -f1)'
alias dash_print_token='kubectl -n kubernetes-dashboard describe secret $token'
alias kdt='dash_set_token && dash_print_token'
EOF
