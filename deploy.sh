#!/bin/sh

az login --service-principal -u ${PLUGIN_AZURE_APPID} -p ${PLUGIN_AZURE_PASSWORD} --tenant ${PLUGIN_AZURE_TENANT} || exit 1
az container create --resource-group ${PLUGIN_RESOURCE_GROUP} --name ${PLUGIN_CONTAINER_NAME} --image ${PLUGIN_IMAGE}:${PLUGIN_IMAGE_VERSION:-latest} --dns-name-label ${PLUGIN_DNS} --ports ${PLUGIN_PORTS:-80} --registry-login-server ${PLUGIN_REGISTRY:-hub.docker.io} --registry-username ${PLUGIN_REGISTRY_USER} --registry-password ${PLUGIN_REGISTRY_PASSWORD} --environment-variables M5=Magna5 ${PLUGIN_ENVVARS//,/ }
