#!/bin/bash

###
# Два запроса списка пользователей.
# Первый идет в MongoDB, второй должен взяться из Redis.
###

curl -o /dev/null -s -w "%{time_total}\n" http://localhost:8080/helloDoc/users
curl -o /dev/null -s -w "%{time_total}\n" http://localhost:8080/helloDoc/users
