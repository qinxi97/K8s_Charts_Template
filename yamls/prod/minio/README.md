#install

 helm install  minio -f values.yaml minio/minio -n infra

#upgrade

helm upgrade  minio -f values.yaml minio/minio -n infra
