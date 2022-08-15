# install jenkins
```
 helm repo add jenkins https://charts.jenkins.io
 helm install jenkins -n jenkins -f jenkins-k8s-values.yaml jenkinsci/jenkins
```
# upgrade jenkins
```
 helm upgrade jenkins -n jenkins -f jenkins-k8s-values.yaml jenkinsci/jenkins
```
#ref: https://www.yuque.com/qinxi-cvygi/kubernetes/bckk3m
