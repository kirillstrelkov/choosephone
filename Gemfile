source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '4.2.4'

# Heroku
gem 'rails_12factor', group: :production
gem 'heroku_rails_deflate', group: :production

gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

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
  gem 'capybara-mechanize'
end
