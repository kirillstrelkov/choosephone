Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
  config.app_host = 'https://www.google.com'
  config.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {js_errors: false})
  end
end
