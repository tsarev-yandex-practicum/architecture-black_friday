#!/bin/bash

###
# Replica set сервера конфигурации
###

docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate({
  _id: "config_server",
  configsvr: true,
  members: [
    { _id: 0, host: "configSrv:27017" }
  ]
})
while (rs.status().myState != 1) { sleep(1000); }
EOF
