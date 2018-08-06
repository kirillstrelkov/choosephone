source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '5.2.0'

gem 'puma'

# Heroku
gem 'rails_12factor', group: :production
gem 'heroku_rails_deflate', group: :production

gem 'bootstrap-sass'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'haml-rails'
gem 'capybara'
gem 'poltergeist'
gem 'redis-rails'

gem 'levenshtein-ffi', require: 'levenshtein'

group :development do
  gem 'guard-rspec', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'cucumber'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end
