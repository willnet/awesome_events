# awesome events

これは、[パーフェクト Ruby on Rails](http://www.amazon.co.jp/%E3%83%91%E3%83%BC%E3%83%95%E3%82%A7%E3%82%AF%E3%83%88-Ruby-Rails-%E3%81%99%E3%81%8C-%E3%81%BE%E3%81%95%E3%81%8A/dp/4774165166)で作成されたサンプルアプリです。

イベント情報を登録／編集したり、イベントに参加登録したりできます。

## 前提条件

次のライブラリをインストールしておいてください。詳しくは書籍を参考にしてください。

* Ruby 2.0.0 以上
* bundler
* sqlite3
* phantomjs
* nodejs
* ImageMagick


## セットアップ方法

まず次のコマンドを実行します。

```
git clone git@github.com:willnet/awesome_events.git
cd awesome_events
./bin/bundle install
./bin/rake db:migrate
```

[Twitter Application Management](https://apps.twitter.com/) で、書籍の通りにTwitterアプリケーションを作成し、作成したアプリケーションの Twitter Api Key と Twitter Api Secret を `config/secrets.yml` に記述します。その後、次のコマンドで WEBrick を起動します。

```
./bin/rails s
```

http://localhost:3000/ にアクセスすると、トップページが表示されているはずです。

8章に記述されている Vagrant にデプロイする場合は、書籍の通りに Vagrant 環境を設定し、次のコマンドでデプロイします。

```
./bin/bundle exec cap staging deploy
```

### テストの実行方法

テストを実行する場合は、次のようにします。

```
./bin/bundle rake spec
```

特定のテストを実行したい場合は次のようにします。例として event_spec.rb を実行するものとします。

```
./bin/bundle exec rspec spec/models/event_spec.rb
```
