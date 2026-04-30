[![Build Status](https://travis-ci.org/kirillstrelkov/choosephone.svg?branch=master)](https://travis-ci.org/kirillstrelkov/choosephone)

# Introduction

Rails web site allows to sort entered phones by their 'points'.

'Points' are taken from http://www.versus.com web site(https://versus.com/en/phone/top).

Technology stack and tools:

### Core Framework & Backend

- **Ruby on Rails:** The core web application framework.
- **Puma:** Fast, concurrent web server for Ruby/Rack.
- **Redis (`redis-rails`):** In-memory data structure store, used for caching and sessions.
- **Levenshtein (`levenshtein-ffi`):** Calculates the Levenshtein distance between strings, used for fuzzy matching phone names.

### Frontend

- **HAML:** HTML abstraction markup language for clean and concise views.
- **jQuery & CoffeeScript:** JavaScript library and language for frontend interaction and scripting.
- **Bootstrap (`bootstrap-sass`):** CSS framework for responsive design and UI components.
- **Turbolinks:** Speeds up page navigation by keeping the current page instance alive and replacing only the body.

### Development & Testing

- **RSpec (`rspec-rails`):** Behavior-Driven Development (BDD) testing framework for unit and integration testing.
- **Cucumber (`cucumber-rails`):** Tool for running automated acceptance tests written in plain language.
- **Capybara & Selenium WebDriver:** Simulates user interaction with the application for browser-based integration testing.
- **Database Cleaner:** Ensures a clean database state before each test run.
- **RuboCop:** Static code analyzer and formatter to enforce Ruby coding style guidelines.
- **Guard (`guard-rspec`):** Automates tasks like running tests automatically when files are modified.
- **Dotenv (`dotenv-rails`):** Loads environment variables from a `.env` file into `ENV`.
- **Byebug:** Debugging tool for Ruby.

### Deployment

- **Heroku (`rails_12factor`):** Cloud platform for deploying and hosting the application.

Live examples:

- https://choose-best-phone.herokuapp.com/
- https://choose-best-phone.herokuapp.com/phones/compare?utf8=%E2%9C%93&phone_names=iphone+5s%2C+htc+one+m8%2C+galaxy+s5%2C+sony+z2%2C+ascend+mate+7%2C+iphone+6%2C+note+4%2C+z3%2C+z3+compact

# Setup

Set environment variable `DRIVER_FOLDER` to folder with chrome/firefox drivers.

Note: `.env` file can be used.

# Testing

```bash
# Start server:
bundle exec rails s

# Run rspec:
bundle exec rspec

# Run cucumber with different browsers:
BROWSER=chrome bundle exec cucumber
BROWSER=firefox bundle exec cucumber

DRIVER=iphone bundle exec cucumber
DRIVER=pixel bundle exec cucumber
```
