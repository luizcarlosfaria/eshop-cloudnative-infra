#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

echo "$(tput setaf 2)Implantando echo1 e echo2 para validação do ambiente...$(tput sgr0)"

kubectl apply -f ./06.1-echo1.yaml

kubectl apply -f ./06.2-echo2.yaml

echo ""
echo ""
echo "Execute"
echo ""
echo "curl -v  http://localhost/echo1?a=1 -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{}'"
echo ""
echo "e"
echo ""
echo "curl -v  http://localhost/echo2?a=1 -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{}'"
echo ""
echo "para validar o ambiente"
