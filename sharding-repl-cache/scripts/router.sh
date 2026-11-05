#!/bin/bash

set -e

###
# Ждем роутер, добавляем шарды
###

until docker compose exec -T mongos_router mongosh --port 27020 --quiet --eval "db.adminCommand('ping')" < /dev/null
do
  sleep 2
done

docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard("shard1/shard1-1:27018,shard1-2:27018,shard1-3:27018")
sh.addShard("shard2/shard2-1:27019,shard2-2:27019,shard2-3:27019")
sh.shardCollection("somedb.helloDoc", { name: "hashed" })
EOF
