#!/bin/bash

AZVARS="M5=Magna5"
for var in ${PLUGIN_ENVVARS//,/ }; do
  AZVARS="${AZVARS} $var=\"${!var:-missing}\""
done


# Print the command being executed
set -x

az login --service-principal -u ${PLUGIN_AZURE_APPID} -p ${PLUGIN_AZURE_PASSWORD} --tenant ${PLUGIN_AZURE_TENANT} || exit 1

CREATE="az container create --resource-group ${PLUGIN_RESOURCE_GROUP} --name ${PLUGIN_CONTAINER_NAME} --image ${PLUGIN_IMAGE}:${PLUGIN_IMAGE_VERSION:-latest} --dns-name-label ${PLUGIN_DNS} --ports ${PLUGIN_PORTS:-80} --registry-login-server ${PLUGIN_REGISTRY:-hub.docker.io} --registry-username ${PLUGIN_REGISTRY_USER} --registry-password ${PLUGIN_REGISTRY_PASSWORD} --environment-variables ${AZVARS}"

# Execute az container deploy command
eval $CREATE
