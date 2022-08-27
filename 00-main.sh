#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

################################
## v1 ------------

set echo off

chmod -R +x ./**/*.sh

cd ./01-ClusterSetup/

./00-main.sh

sleep 10

cd ../02-Resources/

./00-main.sh
