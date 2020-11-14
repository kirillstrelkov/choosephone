[![Build Status](https://travis-ci.org/kirillstrelkov/choosephone.svg?branch=master)](https://travis-ci.org/kirillstrelkov/choosephone)

# Introduction

Rails web site allows to sort entered phones by their 'points'.

'Points' are taken from http://www.versus.com web site(https://versus.com/en/phone/top).

Technology stack:

Ruby on Rails, HAML, jQuery, CoffeeScript, HTML, Bootstrap, CSS, Heroku, Cucumber

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
