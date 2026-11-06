# mongo-sharding-repl

## Запуск

Запускаем конфиг, два шарда по три реплики, роутер и приложение. Команды необходимо выполнять из папки `mongo-sharding-repl`.

```shell
docker compose up -d
```

## Инициализация

Создание replica set у конфиг-сервера. И ожидание, пока он станет primary.

```shell
./scripts/config-server.sh
```

Replica set первого шарда: `shard1-1`, `shard1-2`, `shard1-3`.

```shell
./scripts/shard1.sh
```

Replica set второго шарда: `shard2-1`, `shard2-2`, `shard2-3`.

```shell
./scripts/shard2.sh
```

Роутер иногда поднимается не с первого раза, пока конфиг не готов. Дожидаемся ответа и через него добавляем шарды. Коллекцию `somedb.helloDoc` шардируем по хешу `name`.

```shell
./scripts/router.sh
```

В ответе должны быть `shardAdded` для обоих шардов и `collectionsharded`.

Кладем 1000 документов. Последняя строка в консоли должна показать 1000.

```shell
./scripts/fill.sh
```

## Как проверить

На роутере после вставки уже должно быть 1000. На каждом шарде скрипт печатает число документов и число реплик. Реплик должно быть 3, сумма документов тоже 1000.

```shell
./scripts/count-shard1.sh
```

```shell
./scripts/count-shard2.sh
```
