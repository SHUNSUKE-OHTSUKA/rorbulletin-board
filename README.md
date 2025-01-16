# rorbulletin-board(掲示板)

## 概要

Ruby on Railsを用いて掲示板を開発します。  
投稿の新規投稿/編集/削除機能、ユーザの作成/ログイン機能を実装します。

## 開発環境

* ruby
    * 3.3.6
* rails
    * 8.0.1
* mysql
    * 8.4.3
    * データは永続化

※Docker管理なのでローカル環境へのインストールは不要

## 起動/停止方法

```
docker compose up -d
docker compose down

# 初回起動時のみ
docker compose up -d --build
docker compose exec web bundle exec rake db:create
docker compose exec web rails db:migrate
```

webブラウザで以下のURLを開く  
http://localhost:3000/

※ファイル更新時にアプリケーションへ即時反映(ActiveSupport::FileUpdateChecker)するように設定してるので、デバッグの都度raile再起動は不要

## 開発する際に使用したコマンド

コマンド集[./COMMAND.md]を参照ください