#!/bin/bash

###
# Число документов на втором шарде
###

docker compose exec -T shard2 mongosh --port 27018 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF
