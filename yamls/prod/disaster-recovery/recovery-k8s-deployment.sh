#此脚本用于在k8s集群中快速部署服务,下载完毕后，执行文件夹中fast-deploy.yaml中的内容即可。
#mkdir dir
mkdir -p /data/deployment && cd /data/deployment


#add charts repo
helm repo add roxe-charts https://roxe-charts.oss-us-east-1.aliyuncs.com

#wget OSS yaml
#prod deployment
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-gateway.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-aes.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-commerce.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-content-management.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-coupon.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-gift.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-kyc.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-middle-service.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-opt-admin.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-rmn.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-rps.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-send.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/roxe-user-center.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/pool-service.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/roxe-asset-center.tar.gz
sleep 2
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/roxe-notification.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/roxe-opt-admin.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/roxe-rpc.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/roxe-rts-withdraw.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/roxe-withdraw.tar.gz 
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/backend/rss-tn.tar.gz 
sleep 2


#frontend deployment
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-api-doc.tar.gz && tar xf roxe-api-doc.tar.gz && mv deployment  roxe-api-doc && rm -fr roxe-api-doc.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-checkout-h5.tar.gz && tar xf roxe-checkout-h5.tar.gz && mv deployment  roxe-checkout-h5 && rm -fr roxe-checkout-h5.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-element.tar.gz && tar xf roxe-element.tar.gz && mv deployment  roxe-element && rm -fr roxe-element.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-hash-view.tar.gz && tar xf roxe-hash-view.tar.gz && mv deployment  roxe-hash-view && rm -fr  roxe-hash-view.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-invitation.tar.gz && tar xf roxe-invitation.tar.gz && mv deployment  roxe-invitation && rm -fr  roxe-invitation.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-kyc-h5.tar.gz && tar xf roxe-kyc-h5.tar.gz && mv deployment  roxe-kyc-h5 && rm -fr  roxe-kyc-h5.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-opt-view.tar.gz && tar xf roxe-opt-view.tar.gz && mv deployment  roxe-opt-view && rm -fr  roxe-opt-view.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-score.tar.gz && tar xf roxe-score.tar.gz && mv deployment  roxe-score && rm -fr  roxe-score.tar.gz
sleep 1
wget https://ops-deployer.oss-us-east-1.aliyuncs.com/Dockerfile/frontend/roxe-send-withdraw.tar.gz && tar xf roxe-send-withdraw.tar.gz && mv deployment  roxe-send-withdraw && rm -fr  roxe-send-withdraw.tar.gz



#rm tar.gz
/bin/ls *.tar.gz > ls.list
for TAR in `cat ls.list`
do
/bin/tar -xf $TAR
done
/bin/rm ls.list
rm -fr *.tar.gz

#deploy prod
kubectl apply -f roxe-gateway/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-aes/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-commerce/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-rmn/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-content-management/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-coupon/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-exchange-rate/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-gift/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-kyc/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-middle-service/fast-deploy.yaml
sleep 10
kubectl apply -f rroxe-opt-admin/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-rps/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-send/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-user-center/fast-deploy.yaml
sleep 10
kubectl apply -f pool-service/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-asset-center/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-notification/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-opt-admin/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-rpc/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-rts-withdraw/prod/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-withdraw/prod/fast-deploy.yaml
sleep 10
kubectl apply -f rss-tn/prod/fast-deploy.yaml
sleep 10
#deploy frontend
kubectl apply -f roxe-element/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-opt-view/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-api-doc/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-invitation/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-score/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-checkout-h5/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-kyc-h5/fast-deploy.yaml
sleep 10
kubectl apply -f roxe-send-withdraw/fast-deploy.yaml
sleep 10

