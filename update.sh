#!/usr/bin/env bash

git pull
kubectl delete -f docs-helm.yaml
kubectl apply -f docs-helm.yaml
