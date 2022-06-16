#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

# dashboard #################################################################

echo "$(tput setaf 2)Fazendo deploy do Kubernetes Dashboard...$(tput sgr0)"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

# dashboard #################################################################

kubectl apply -f ./03.1-dashboard.accounts.yaml

kubectl apply -f ./03.2-dashboard.ingress.yaml

# bash alias #################################################################

echo "$(tput setaf 2)Recriado alias (kdt)...$(tput sgr0)"

cat ~/.bash_aliases | grep -v kdt= >~/.bash_aliases

cat <<EOF | tee ~/.bash_aliases
alias kdt='kubectl -n kubernetes-dashboard describe secret \$(kubectl -n kubernetes-dashboard get secret | grep admin-user-token | cut -d " " -f1)'
EOF

cat ~/.bash_aliases

