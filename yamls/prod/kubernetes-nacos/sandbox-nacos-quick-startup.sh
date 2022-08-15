#!/usr/bin/env bash
echo "1、create ali pvc"
kubectl create -f ./deploy/ali-data/pvc.yaml -n sandbox

echo "2、 mysql startup"
kubectl create -f ./deploy/mysql/mysql-ali.yaml -n sandbox

echo "3、nacos quick startup"
kubectl create -f ./deploy/nacos/nacos-quick-start.yaml -n sandbox
