## 线上k8s集群灾备恢复方案

## 一、kubernetes介绍

### 1.1、kubernetes历史
K8S是建立在谷歌内部有超过10年的历史，来源于谷歌内部的Borg系统，集结了Borg的精华。
Kubernetes是容器集群管理系统，是一个开源的平台，可以实现容器集群的自动化部署、自动扩缩容、维护等功能。


### 1.2、kubernetes优势

可移植: 支持公有云，私有云，混合云，多重云（multi-cloud）
可扩展: 模块化, 插件化, 可挂载, 可组合
自动化: 自动部署，自动重启，自动复制，自动伸缩/扩展，自动修复


## 二、kubernetes灾备介绍

k8s集群的稳定性和众多因素有关，比如集群的存储，网络和物理资源的好坏都是影响稳定性的重要一环。k8s的自动修复，自动扩展等特性足够修复这些问题，大部分情况下，因为成本因素，我们不会配置自动扩展node节点服务器，如果内存或CPU资源不足，或者服务启动参数配置不当，有可能会导致服务高峰期争抢资源而导致node节点连锁排斥pod服务的情况，也有可能存在导致集群奔溃的极端情况。

默认情况下k8s集群出现奔溃的可能性非常小，常出现的问题都是集群资源不足带来的，而结合prometheus监控，我们可以及时处理并掌控在可控范围内。


本文讨论极端情况下，k8s集群奔溃该如何处理。
由于集群中运行的大部分是无状态的服务，服务产出的数据都存放在数据库和redis中，因而我们需要做的就是恢复服务的正常运行即可。

### 2.1、创建服务器密钥
用于登录集群服务器，执行命令

### 2.2、创建kubernetes集群
注意: 选择集群规格，地域，容器运行时（docker），服务器规格（> 4C 8G），系统盘等。


### 2.3、检查nginx-ingress 创建情况
默认情况下，kubernetes集群创建完毕后，在kube-system命名空间中会创建一个ingress，对应一个外网SLB或者一个内网SLB（创建集群时选择）。
如果只有一个内网或只有一个外网SLB，可自行创建（#ref:https://www.alibabacloud.com/help/zh/doc-detail/151506.html）

### 2.4、申请弹性IP绑定到集群master服务器


### 2.5、创建命名空间
登录master节点服务器 
ssh -i /Users/admin/code/roxe/roxe.pem root@IP

创建命名空间
kubectl create namespace sandbox prod pre jenkins frontend infra

我们也可以登录k8s web控制台创建命名空间

## 2.6、登录k8s master服务器，执行脚本，发布服务
### 2.6.1、安装helm工具
登录k8s master节点服务器安装helm工具（#ref: https://www.yuque.com/qinxi-cvygi/kubernetes/vbhykc）。
集群中一般安装有helm工具，一般版本较低，在执行后续命令操作时，可能会出错，此处最好更新到文档中版本。


### 2.6.2、集群中创建dockerconfig secret
此处创建secret 用来在集群中拉取镜像仓库中私有镜像（#ref:https://www.yuque.com/qinxi-cvygi/kubernetes/bmyz0t）

### 2.6.3、部署服务
执行脚本（#ref: http://git.ddesk.io/roxe-opt/roxe-charts/-/blob/master/yamls/prod/disaster-recovery/recovery-k8s-deployment.sh），快速完成服务部署。
集群中已经含有备份，可尝试使用备份恢复。


## 2.7、修改解析

### 2.7.1、后端服务
roxe-gateway     
gw-us-aly.roxepro.top && risn.roxe.pro      ---》ingress 外网IP地址

roxe-eureka-pre  
eureka-us-aly.roxevip.top   ---》ingress 内网IP地址

roxe-gateway-sandbox 
roxe-gateway-sandbox.roxe.pro   ---》ingress 外网IP地址


### 2.7.2、前端服务
roxe-api-doc.roxe.pro          ---》ingress 外网IP地址
pay-checkout.roxe.io           ---》ingress 外网IP地址
element.roxe.io                    ---》ingress 外网IP地址
api.vaba.tech                  ---》ingress 外网IP地址
invitation.roxe.io             ---》ingress 外网IP地址
pay-kyc.roxe.io                ---》ingress 外网IP地址
roxe-opt-view-us.roxepro.top   ---》ingress 外网IP地址
score.roxe.io                  ---》ingress 外网IP地址
roxe-send-withdraw.roxe.io     ---》ingress 外网IP地址


## 2.8、配置域名证书
上传HTTPS证书到集群中
https://gw-us-aly.roxepro.top

#ref: https://www.yuque.com/qinxi-cvygi/kubernetes/omzg4o


## 2.9、部署rocketmq
下载gitlab中脚本（#ref: http://git.ddesk.io/roxe-opt/roxe-charts/-/tree/master/yamls/prod/kubernetes-rocketmq），并上传至k8s集群，参考文档，完成部署。


——————————————————————————————————
完成以上7个步骤，即可恢复服务访问




- - - -  - - - - - - - - - - - -  后续操作[辅助服务] - - - -  - - - - - - - - - 

## 2.10、部署ack ingress

### 2.10.1、安装ingress
#ref: https://cs.console.aliyun.com/?spm=5176.2020520112.favorite.dcsk.6a7d34c0KN8ERL&accounttraceid=f9744544019c438a89b29b4eb5296d8cantm#/next/app-catalog/ack/incubator/ack-ingress-nginx

### 2.10.2、域名解析
storage.infra.roxepro.top    -----> 域名解析至ack ingress IP (ingressClassName: nginx-roxe) 
rocketmq-us-aly.roxepro.top  -----> 域名解析至ack ingress IP (ingressClassName: nginx-roxe)
jenkins.roxepro.top              -----> 域名解析至ack ingress IP 


## 2.11、部署Jenkins in k8s

### 2.11.1、部署Jenkins

下载gitlab中部署脚本（#ref: http://git.ddesk.io/roxe-opt/roxe-charts/-/tree/master/yamls/prod/kubernetes-jenkins），并上传至k8s集群，完成jenkins部署（参考#ref: https://www.yuque.com/qinxi-cvygi/kubernetes/bckk3m）。

Jenkins必须插件:
1、Aliyun OSS Uploader 
2、Docker Pipeline
3、git
4、Git Parameter
5、JDK Parameter Plugin
6、Kubernetes（1.30.1）
7、Maven Integration（3.12）
8、Minio
9、Minio Storage（0.0.3）
10、NodeJS（1.4.0）
11、Pipeline Maven Integration Plugin（3.10.0）
12、Pipeline（2.6）
13、Publish Over SSH
14、ThinBackup（1.10）


### 2.11.2、恢复配置

A、 安装thinBackup Configuration 插件


B、拷贝备份配置到Jenkins容器中（#ref: https://www.yuque.com/qinxi-cvygi/kubernetes/qkevmo）
下载Jenkins配置（http://git.ddesk.io/roxe-opt/roxe-charts/-/blob/master/yamls/prod/kubernetes-jenkins/jenkins-config-backup-2022-03-15.tar.gz）,并上传至Jenkins pod，默认备份目录: /var/jenkins_home/backup


C、jenkins 页面恢复配置，重启jenkins(#ref: https://www.yuque.com/testpu/pro/ygnyg6)


### 2.11.3、配置Jenkins Credentials 连接k8s集群

默认jenkins 配置Credentials 中配置 dockerconfig用来存储连接docker仓库的用户名，密码
gitlab-auth	用来存储Jenkins连接gitlab的用户名和密码
kubeconfig 用来存储jenkins连接k8s集群的密钥


后记：
若想缩短上述可能出现的情况带来的时间成本，则要建立在牺牲金钱成本上，部署备用集群，一旦运行服务集群出现问题，则直接切到备用集群，部署服务，修改域名解析即可。

### 2.11.4、添加jenkins 中Global Tool Configuration 的 jdk、maven、nodejs 自动安装
此处配置自动安装jdk时，需要oracle 用户名和密码。

### 2.11.5、集群所在vpc 出口IP地址授权访问gitlab仓库【可选】
若集群所在出口IP网关IP地址未变，此步可越过。


## 2.12  部署沙盒&线上nacos集群

备份配置存放于OSS 

沙盒nacos (#ref: https://ops-deployer.oss-us-east-1.aliyuncs.com/backup/sandbox-nacos_2022-03-21.tar.gz)

线上nacos集群（#ref: https://ops-deployer.oss-us-east-1.aliyuncs.com/backup/prod-nacos-cluster_2022-03-23.tar.gz）



