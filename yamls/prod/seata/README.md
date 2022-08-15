##### #1、登录服务器

ssh -i /Users/admin/code/roxe/roxe.pem root@172.26.8.129



##### #2、上传配置至Nacos配置中心

脚本执行原理: 将config.txt的key-value值通过调用nacos添加配置接口导入到nacos配置管理里面

cd /opt/seata/conf 

bash nacos-config.sh -h nacos-us-aly.roxepro.top -p 80 -g SEATA_GROUP -t 3a059552-5c1a-42b8-b5a4-652ba5be8457



##### #3、登录k8s master服务器，部署应用

kubectl apply -f  seata-ha-server.yaml



##### #4、登录nacos配置中心检查服务





#后记：

Seata version: 1.4.0

部署参考文档：https://www.yuque.com/qinxi-cvygi/kubernetes/gyv9sf