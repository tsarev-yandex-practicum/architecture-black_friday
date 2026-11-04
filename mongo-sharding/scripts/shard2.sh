#!/bin/bash

###
# Replica set второго шарда
###

docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
rs.initiate({
  _id: "shard2",
  members: [
    { _id: 0, host: "shard2:27019" }
  ]
})
while (rs.status().myState != 1) { sleep(1000); }
EOF
