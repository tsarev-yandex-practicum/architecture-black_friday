#!/bin/bash

set -e

###
# Число документов и реплик первого шарда
###

docker compose exec -T shard1-1 mongosh "mongodb://shard1-1:27018,shard1-2:27018,shard1-3:27018/somedb?replicaSet=shard1" --quiet --eval "db.helloDoc.countDocuments()"

docker compose exec -T shard1-1 mongosh --port 27018 --quiet --eval "rs.status().members.length"
