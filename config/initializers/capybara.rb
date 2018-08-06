require 'capybara'
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
  config.javascript_driver = :poltergeist
  config.default_max_wait_time = 10
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end
