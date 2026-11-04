#!/bin/bash

set -e

###
# Число документов и реплик второго шарда
###

docker compose exec -T shard2-1 mongosh "mongodb://shard2-1:27019,shard2-2:27019,shard2-3:27019/somedb?replicaSet=shard2" --quiet --eval "db.helloDoc.countDocuments()"

docker compose exec -T shard2-1 mongosh --port 27019 --quiet --eval "rs.status().members.length"
