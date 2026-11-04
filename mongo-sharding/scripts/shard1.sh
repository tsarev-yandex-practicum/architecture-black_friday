#!/bin/bash

###
# Replica set первого шарда
###

docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
rs.initiate({
  _id: "shard1",
  members: [
    { _id: 0, host: "shard1:27018" }
  ]
})
while (rs.status().myState != 1) { sleep(1000); }
EOF
