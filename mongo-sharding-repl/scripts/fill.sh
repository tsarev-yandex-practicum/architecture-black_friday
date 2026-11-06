#!/bin/bash

###
# Кладем 1000 документов
###

docker compose exec -T mongos_router mongosh --port 27017 --quiet <<EOF
use somedb
for (var i = 0; i < 1000; i++) db.helloDoc.insertOne({ age: i, name: "ly" + i })
db.helloDoc.countDocuments()
EOF
