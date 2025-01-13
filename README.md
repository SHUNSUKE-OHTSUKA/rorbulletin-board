# rorbulletin-board(掲示板)

## 概要

Ruby on Railsを用いて掲示板のCRUD機能を開発します

## 開発環境

* ruby
    * 3.3.6
* rails
    * 8.0.1
* mysql
    * 8.4.3

※Docker管理なのでローカル環境へのインストールは不要

## 起動方法

```
docker compose up -d

# 初回起動時のみ
docker compose build
docker compose exec web bundle exec rake db:create
```

webブラウザで以下のURLを開く  
http://localhost:3000/

