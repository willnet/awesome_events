source 'https://rubygems.org'

gem 'rails', '4.0.4'
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

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-bundler"
  gem "capistrano3-unicorn"
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
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
