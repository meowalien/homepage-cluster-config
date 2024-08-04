#!/bin/bash

mongosh "mongodb://root:%21mJack00@mongodb-cluster-0.mongodb-cluster-svc.mongodb-cluster.svc.cluster.local:27017,mongodb-cluster-1.mongodb-cluster-svc.mongodb-cluster.svc.cluster.local:27017,mongodb-cluster-2.mongodb-cluster-svc.mongodb-cluster.svc.cluster.local:27017/admin?replicaSet=mongodb-cluster&ssl=false"