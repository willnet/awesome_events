source 'https://rubygems.org'

gem 'rails', '4.1.0'
gem 'sqlite3'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem "ransack"
gem 'carrierwave'
gem 'mini_magick'


gem 'status_show_plugin', git: 'git@bitbucket.org:udzura/railsbook-status_show_plugin.git'
gem 'simple_auth_plugin', git: 'git@bitbucket.org:udzura/railsbook-simple_auth_plugin.git', require: 'simple_auth_plugin/railtie'

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-bundler"
  gem "capistrano3-unicorn"
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta', github: 'rspec/rspec-rails'
  gem 'rspec-core', '~> 3.0.0.beta', github: 'rspec/rspec-core'
  gem 'rspec-expectations', '~> 3.0.0.beta', github: 'rspec/rspec-expectations'
  gem 'rspec-mocks', '~> 3.0.0.beta', github: 'rspec/rspec-mocks'
  gem 'rspec-support', '~> 3.0.0.beta', github: 'rspec/rspec-support'
  gem 'factory_girl_rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
end

group :staging, :production do
  gem 'unicorn'
end
