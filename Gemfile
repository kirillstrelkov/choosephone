# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '5.2.0'

gem 'puma'

# Heroku
gem 'rails_12factor', group: :production

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'sass-rails'
gem 'uglifier'

gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'turbolinks'

gem 'capybara'
gem 'haml-rails'
gem 'redis-rails'
gem 'selenium-webdriver'

gem 'levenshtein-ffi', require: 'levenshtein'

group :development do
  gem 'guard-rspec', require: false
  gem 'rubocop'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'chromedriver-helper'
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end
