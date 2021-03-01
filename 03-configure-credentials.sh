#!/usr/bin/env bash

. magic.sh

load_config



echo '----------------------------------------------'
echo '     Configuring Credentials in Prod cluster'
echo '----------------------------------------------'

echo ''
echo 'Continue to switch to the Prod Cluster...'
pe "kubectx ${PROD_CLUSTER}"

echo ''
echo 'Continue to create required namespaces'
pe "kubectl create ns ${PROD_NAMESPACE}"
pe "kubectl create ns ${PROD_DATA_NAMESPACE}"

echo ''
echo 'Creating Prod credentials'
cat kubernetes/cicd/argocd/rabbit-secret.template.yml | sed "s/RABBITMQ_PASSWORD/$PROD_RABBITMQ_PASSWORD/" | kubectl create -n ${PROD_NAMESPACE} -f -
cat kubernetes/cicd/argocd/rabbit-secret.template.yml | sed "s/RABBITMQ_PASSWORD/$PROD_RABBITMQ_PASSWORD/" | kubectl create -n ${PROD_DATA_NAMESPACE} -f -

cat kubernetes/cicd/argocd/redis-secret.template.yml | sed "s/REDIS_PASSWORD/$PROD_REDIS_PASSWORD/" | kubectl create -n ${PROD_NAMESPACE} -f -
cat kubernetes/cicd/argocd/redis-secret.template.yml | sed "s/REDIS_PASSWORD/$PROD_REDIS_PASSWORD/" | kubectl create -n ${PROD_DATA_NAMESPACE} -f -

cat kubernetes/cicd/argocd/wavefront-token.template.yml | sed "s/WAVEFRONT_TOKEN/$PROD_WAVEFRONT_TOKEN/" | kubectl create -n ${PROD_NAMESPACE} -f -
