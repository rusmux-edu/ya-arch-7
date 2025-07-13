#!/usr/bin/env bash

openssl genrsa -out client-developer.key 2048
openssl req -new -key client-developer.key -out client-developer.csr -subj "/CN=client-developer/OU=developers"
openssl x509 -req -in client-developer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out client-developer.crt -days 365

kubectl config set-credentials client-developer --client-certificate=client-developer.crt --client-key=client-developer.key
kubectl config set-context client-developer-context --cluster=minikube --namespace=client --user=client-developer

openssl genrsa -out security-user.key 2048
openssl req -new -key security-user.key -out security-user.csr -subj "/CN=security-user/OU=security"
openssl x509 -req -in security-user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out security-user.crt -days 365

kubectl config set-credentials security-user --client-certificate=security-user.crt --client-key=security-user.key
kubectl config set-context security-user-context --cluster=minikube --namespace=production --user=security-user

kubectl config get-contexts
