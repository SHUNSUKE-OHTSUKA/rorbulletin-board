# 使用したコマンド集

## rails初期化

railsプロジェクトの作成

```
docker-compose run web rails new . --force --database=mysql
```

## Docker起動

学習環境をDockerコンテナとして出力する

```
docker compose build
docker compose up -d
```

## Docker停止

```
docker compose down
```

## DB初期化

```
docker compose exec web bundle exec rake db:create
```

## rails操作

Postsコントローラの作成

```
docker compose exec web rails generate controller Posts
```