# frozen_string_literal: true

require 'capybara'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :firefox
  config.default_max_wait_time = 10
end
