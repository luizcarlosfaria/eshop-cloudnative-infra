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



## Exbindo credenciais
echo ""
echo "$(tput setaf 2)Dashboard ---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress gago-dashboard-ingress -n kubernetes-dashboard -o=jsonpath='{.spec.rules[].host}'):30777/"
echo "$(tput setaf 1) $( kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user-token | cut -d " " -f1) | grep token: ) $(tput sgr0)"

echo ""
echo "$(tput setaf 2)Minio ---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress gago-minio-ingress -n minio-operator -o=jsonpath='{.spec.rules[].host}')/"
#echo "$(tput setaf 1) $(kubectl minio proxy -n minio-operator | grep JWT) $(tput sgr0)"
echo "$(tput setaf 2)accesskey:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-creds-secret  -o jsonpath="{.data.accesskey}" | base64 -d)"
echo "$(tput setaf 2)secretkey:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-creds-secret  -o jsonpath="{.data.secretkey}" | base64 -d)"
echo "$(tput setaf 2)CONSOLE_ACCESS_KEY:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-user-1 -o jsonpath="{.data.CONSOLE_ACCESS_KEY}" | base64 -d)"
echo "$(tput setaf 2)CONSOLE_SECRET_KEY:$(tput sgr0) $(kubectl get -n eshop-resources secret eshop-user-1 -o jsonpath="{.data.CONSOLE_SECRET_KEY}" | base64 -d)"


echo ""
echo "$(tput setaf 2)PgAdmin ---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress pgadmin-ingress -n eshop-resources -o=jsonpath='{.spec.rules[].host}')/"
echo "$(tput setaf 2)Usuario:$(tput sgr0) $(kubectl get secret pgadmin -n eshop-resources -o=jsonpath='{.data.pgadmin-username}' | base64 -d )"
echo "$(tput setaf 2)Senha:$(tput sgr0) $(kubectl get secret pgadmin -n eshop-resources -o=jsonpath='{.data.pgadmin-password}' | base64 -d )"
echo "$(tput setaf 2)Senha do usuário postgres:$(tput sgr0) $(kubectl get secret superuser-secret -n eshop-resources -o=jsonpath='{.data.password}' | base64 -d )"

echo ""
echo "$(tput setaf 2)RabbitMQ ---------------------------------------------------------$(tput sgr0)"
echo "https://$(kubectl get ingress rabbitmq-ingress -n eshop-resources -o=jsonpath='{.spec.rules[].host}')/"
echo "$(tput setaf 2)Usuario:$(tput sgr0) $(kubectl get -n eshop-resources secret rabbitmq-secret--admin -o jsonpath="{.data.username}" | base64 -d)"
echo "$(tput setaf 2)Senha:$(tput sgr0) $(kubectl get -n eshop-resources secret rabbitmq-secret--admin -o jsonpath="{.data.password}" | base64 -d)"



echo ""