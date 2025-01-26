# 使用したコマンド集

## rails初期化

Railsプロジェクトの作成

```
docker-compose run web rails new . --force --database=mysql
```

## Docker起動

学習環境をDockerコンテナで起動します

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
docker compose exec web rails db:migrate
```

## Rails操作

### 新規投稿、編集、削除機能の追加

```
# controllerの作成
docker compose exec web rails generate controller Posts

# modelの作成
docker compose exec web rails generate model Posts title:string content:string
docker compose exec web rails db:migrate
```

### ユーザ管理機能の追加

```
# controllerの作成
docker compose exec web rails generate controller Users new

# modelの作成
docker compose exec web rails generate model User name:string email:string
docker compose exec web rails generate migration add_index_to_users_email
docker compose exec web rails generate migration add_password_digest_to_users password_digest:string
docker compose exec web rails db:migrate
```

### ログイン機能の追加

```
# Sessions controllerの作成
docker compose exec web rails generate controller Sessions new
docker compose exec web rails generate integration_test users_login
```

### ログイン機能の追加(Remember me 機能)

```
docker compose exec web rails generate migration add_remember_digest_to_users remember_digest:string

docker compose exec web rails db:migrate
```

### テスト

Railsに標準で組み込まれてるテストフレームワークを使います

```
# 単体テスト
## modelのテスト(./test/modelsを実行)
docker compose exec web rails test:models

# 結合テスト
docker compose exec web rails test:integration
```
