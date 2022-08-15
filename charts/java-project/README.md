*  关于helm chart 打包的使用说明
```
 例子：
 1、 打包，打包要前先改charts/nodejs/Chart.yaml 里的版本号
 helm package charts/nodejs  
 
 2、 生成新的索引文件
 wget https://roxe-charts.oss-us-east-1.aliyuncs.com/index.yaml -O old-index.yaml
 helm repo index . --url https://roxe-charts.oss-us-east-1.aliyuncs.com --merge old-index.yaml   
 
 3、上传OSS
 index.yaml  和 nodejs-$NEW_VERSION.tgz 放到 oss 上就可以了
 
 4、应用

  使用时将应用加入k8s本地仓库，项目引用即可
```

*  关于修改Java chart模板的介绍

```
template:
    metadata:
      labels:
       {{- include "java-project.selectorLabels" . | nindent 8 }}
###此处为新添加的mse 无损下线功能        
      annotations:
        msePilotAutoEnable: 
          {{- toYaml .Values.MsePilotAutoEnable | nindent 10 }}
        msePilotCreateAppName: 
         {{- toYaml .Values.MsePilotCreateAppName | nindent 10 }}


```

*  关于Java项目的健康检查

```
 java 项目pod 存活检查liveness和就绪检查readiness；每个pod最大重启时间：initialDelaySeconds + （failureThreshold * periodSeconds）

 此模板设置为：40 + （10 * 10）=140s；等待40s开始探测，每隔10s，探测10次，只要大于1次小于10次探测成功即可通过存活检查；10次过后杀死容器，重启；容器主动退出默认等待30s

```
