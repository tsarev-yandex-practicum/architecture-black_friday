#!/bin/bash

set -e

###
# Ждем роутер, добавляем шарды
###

until docker compose exec -T mongos_router mongosh --port 27017 --quiet --eval "db.adminCommand('ping')" < /dev/null
do
  sleep 2
done

docker compose exec -T mongos_router mongosh --port 27017 --quiet <<EOF
sh.addShard("shard1/shard1:27018")
sh.addShard("shard2/shard2:27018")
sh.shardCollection("somedb.helloDoc", { name: "hashed" })
EOF
