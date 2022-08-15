#!/usr/bin/env bash
echo "1、delete nacos pod"
kubectl delete -f ./deploy/nacos/nacos-quick-start.yaml -n sandbox

echo "2、delete mysql pod"
kubectl delete -f ./deploy/mysql/mysql-ali.yaml -n sandbox

echo "3、delete nacos pvc"
kubectl delete -f ./deploy/ali-data/pvc.yaml -n sandbox
