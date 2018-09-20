#!/usr/bin/env bash
docker build . -t registry.cn-qingdao.aliyuncs.com/wangdali/docs-helm:0.0.1
helm upgrade -f ./docs-helm/values.yaml docs-helm ./docs-helm