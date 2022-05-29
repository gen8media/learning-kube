#!/bin/bash

# > gcloud container clusters delete

is_minikube_active=$(kubectl config current-context)
#echo "-- $is_minikube_active"

kubectl get all

kubectl delete ingress mongoex-ingress
kubectl delete deployment mongoex-deployment
kubectl delete deployment mongodb-deployment
kubectl delete service mongo-express-service
kubectl delete service mongodb-service
#kubectl delete pvc pvc-mongo
#kubectl delete pv pv-mongo
#kubectl delete sc sc-mongo
kubectl delete configmap mongo-configmap
kubectl delete secret mongodb-secret

if [ $is_minikube_active == "minikube" ]; then
  echo "MiniKube is active"
  minikube stop
  minikube delete
  minikube delete service mongodb-service
  minikube delete service mongo-express-service
  minikube delete secret mongodb-secret
  minikube delete configmap mongo-configmap
fi

kubectl get all
kubectl get services
kubectl get secrets
kubectl get configmaps
