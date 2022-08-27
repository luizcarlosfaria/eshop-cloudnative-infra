#!/bin/bash

#=============================================================================
# Copyright Luiz Carlos Faria 2022. All Rights Reserved.
# This file is licensed under the MIT License.
# License text available at https://opensource.org/licenses/MIT
#=============================================================================

################################

set echo off

chmod -R +x ../**/*.sh

################################

./01-tools.sh

./04-namespaces.sh

./06-echo.sh

#./09-Minio.sh

#./10-Keycloak.sh
