#!/bin/bash

set -e

###
# Replica set второго шарда, три члена
###

until docker compose exec -T shard2-1 mongosh --port 27018 --quiet --eval "db.adminCommand('ping')" < /dev/null
do
  sleep 2
done

until docker compose exec -T shard2-2 mongosh --port 27018 --quiet --eval "db.adminCommand('ping')" < /dev/null
do
  sleep 2
done

until docker compose exec -T shard2-3 mongosh --port 27018 --quiet --eval "db.adminCommand('ping')" < /dev/null
do
  sleep 2
done

docker compose exec -T shard2-1 mongosh --port 27018 --quiet <<EOF
rs.initiate({
  _id: "shard2",
  members: [
    { _id: 0, host: "shard2-1:27018" },
    { _id: 1, host: "shard2-2:27018" },
    { _id: 2, host: "shard2-3:27018" }
  ]
})
var ready = false
while (!ready) {
  try {
    var members = rs.status().members
    for (var i = 0; i < members.length; i++) {
      if (members[i].state == 1) ready = true
    }
  } catch (e) {
    ready = false
  }
  if (!ready) sleep(1000)
}
EOF
