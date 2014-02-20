# -*- coding: utf-8 -*-

# unicornのプロセスがリスンするアドレスとポートを指定
listen "127.0.0.1:3000"

# pid fileの位置を指定する
pid "tmp/pids/unicorn.pid"

# ワーカーの数を指定する
worker_processes 2

# リクエストのタイムアウト秒を指定する
timeout 15

# ダウンタイムなくすため、アプリをプレロード
preload_app true

# unicornのログ出力先を指定
stdout_path "log/unicorn-stdout.log"
stderr_path "log/unicorn-stderr.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
