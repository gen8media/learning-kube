#!/bin/bash
# kube_dir

# > gcloud container clusters create mongo-test  --num-nodes = 2
# > gcloud container clusters create mongo-test --num-nodes=2 --disk-size=30 --preemptible

is_minikube_active=$(kubectl config current-context)
is_mongo_ns=$(kubens | grep "ns-mongo")

echo "--- $is_mongo_ns"
#kubectl create namespace ns-mongo

if [ $is_mongo_ns != "ns-mongo" ]; then
  kubectl create namespace ns-mongo
fi

if [ $is_minikube_active == "minikube" ]; then
  echo "Add commands for minikube"
fi

kubens ns-mongo
kubectl get all

kubectl apply -f mongo-secret.yaml
kubectl apply -f mongo-configmap.yaml
#kubectl apply -f mongo-pv.yaml
kubectl apply -f mongodb-sc.yaml
kubectl apply -f mongo-pvc.yaml
kubectl apply -f mongoDB_Deployment.yaml

#sleep 240

kubectl apply -f mongoEx_Deployment.yaml
kubectl apply -f mongo-ingress.yaml

kubectl get pods
