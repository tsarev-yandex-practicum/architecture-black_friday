#!/bin/bash

set -e

###
# Число документов и реплик второго шарда
###

docker compose exec -T shard2-1 mongosh "mongodb://shard2-1:27018,shard2-2:27018,shard2-3:27018/somedb?replicaSet=shard2" --quiet --eval "db.helloDoc.countDocuments()"

docker compose exec -T shard2-1 mongosh --port 27018 --quiet --eval "rs.status().members.length"
