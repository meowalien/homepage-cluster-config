#!/bin/bash
export HTTPS_PROXY=localhost:8888
kubectl -n mongodb-cluster port-forward svc/mongodb-cluster-svc 27017:27017

kubectl -n mongodb-cluster port-forward pod/mongodb-cluster-0 27017:27017
kubectl -n mongodb-cluster port-forward pod/mongodb-cluster-0 27018:27017
kubectl -n mongodb-cluster port-forward pod/mongodb-cluster-0 27019:27017

mongosh "mongodb://root:%21mJack00@localhost:27017,localhost:27019,localhost:27019/admin?replicaSet=mongodb-cluster&ssl=false"
mongosh "mongodb://root:%21mJack00@127.0.0.1:27017,127.0.0.1:27019,127.0.0.1:27019/admin?replicaSet=mongodb-cluster&ssl=false"