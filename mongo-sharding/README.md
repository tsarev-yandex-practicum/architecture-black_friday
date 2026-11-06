# mongo-sharding

## Запуск

Запускаем конфиг, два шарда, роутер и приложение. Команды необходимо выполнять из папки `mongo-sharding`.

```shell
docker compose up -d
```

## Инициализация

Создание replica set у конфиг-сервера. И ожидание, пока он станет primary.

```shell
./scripts/config-server.sh
```

То же самое для первого шарда:

```shell
./scripts/shard1.sh
```

И для второго:

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

На роутере после вставки уже должно быть 1000. Отдельно считаем документы на шардах, сумма тоже 1000.

```shell
./scripts/count-shard1.sh
```

```shell
./scripts/count-shard2.sh
```
