#!/bin/bash

# Get PLUGIN_ENVVARS into env.txt so that env sustitution can be done
echo $PLUGIN_ENVVARS > env.txt

ENV_VARS=$(envsubst < env.txt)

# PLUGIN_ENVVARS has ',' as an Internal field separator - IFS
# This is a most preferred way to split string if source string has spaces.
IFS=','

# Read array ENV_VARS into ARR
read -ra ARR <<< "$ENV_VARS"

# create space sperated string
for i in "${ARR[@]}"; do
    ENV_VARS_STR="$ENV_VARS_STR $i"
done

# Store command to be executed in to CREATE, otherwise it adds single quotes to variables
CREATE="az container create --resource-group ${PLUGIN_RESOURCE_GROUP} --name ${PLUGIN_CONTAINER_NAME} --image ${PLUGIN_IMAGE}:${PLUGIN_IMAGE_VERSION:-latest} --dns-name-label ${PLUGIN_DNS} --ports ${PLUGIN_PORTS:-80} --registry-login-server ${PLUGIN_REGISTRY:-hub.docker.io} --registry-username ${PLUGIN_REGISTRY_USER} --registry-password ${PLUGIN_REGISTRY_PASSWORD} --environment-variables M5=Magna5 ${ENV_VARS_STR}"

# Execute
az login --service-principal -u ${PLUGIN_AZURE_APPID} -p ${PLUGIN_AZURE_PASSWORD} --tenant ${PLUGIN_AZURE_TENANT} || exit 1
eval $CREATE