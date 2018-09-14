#!/usr/bin/env bash

git pull
docker build . -t registry.cn-qingdao.aliyuncs.com/wangdali/docs-helm:latest
docker push registry.cn-qingdao.aliyuncs.com/wangdali/docs-helm:latest
kubectl delete -f docs-helm.yaml
kubectl apply -f docs-helm.yaml
