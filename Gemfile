source 'https://rubygems.org'

gem 'rails', '4.1.1'
gem 'sqlite3', '~> 1.3.9'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '~> 2.5.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails', '~> 3.1.0'
gem 'turbolinks', '~> 2.2.2'
gem 'omniauth', '~> 1.2.1'
gem 'omniauth-twitter', '~> 1.0.1'
gem 'kaminari', '~> 0.15.1'
gem 'kaminari-bootstrap', '~> 3.0.1'
gem "ransack", '~> 1.2.2'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 3.7.0'

group :development do
  gem "capistrano", "3.1.0"
  gem "capistrano-rails"
  gem "capistrano-bundler"
  gem "capistrano3-unicorn"
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta', github: 'rspec/rspec-rails'
  gem 'rspec-core', '~> 3.0.0.beta', github: 'rspec/rspec-core'
  gem 'rspec-expectations', '~> 3.0.0.beta', github: 'rspec/rspec-expectations'
  gem 'rspec-mocks', '~> 3.0.0.beta', github: 'rspec/rspec-mocks'
  gem 'rspec-support', '~> 3.0.0.beta', github: 'rspec/rspec-support'
  gem 'factory_girl_rails', '~> 4.4.1'
end

group :test do
  gem 'shoulda-matchers', '~> 2.6.0'
  gem 'capybara', '~> 2.2.1'
  gem 'poltergeist', '~> 1.5.0'
  gem 'database_cleaner', '~> 1.2.0'
end

group :staging, :production do
  gem 'unicorn'
end
