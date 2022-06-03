#!/bin/bash

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
