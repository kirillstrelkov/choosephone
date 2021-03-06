# frozen_string_literal: true

require 'json'
require 'open-uri'
require 'levenshtein'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

module VersusComHelper
  include Capybara::DSL

  VERSUS_URL = 'https://www.versus.com'
  VERSUS_URL_WITH_TO_PHONE = 'https://versus.com/en/sony-xperia-5-ii-vs-'
  AMAZON_SEARCH_URL = 'https://versus.com/api/prices/pricetags/get'

  def get_price(phone_name)
    names_json = get_phone_names_json(phone_name)
    return { error: t(:error_not_found) } if names_json.empty?

    name_url = names_json.first['name_url']
    uri = URI.escape("#{AMAZON_SEARCH_URL}?name_url=#{name_url}&country=DE&type=vs")
    begin
      json_obj = JSON.parse(open(uri).read, symbolize_names: true)
      json_obj[:pricetags][0]
    rescue StandardError
      { error: t(:unknown_error_occurred) }
    end
  end

  def get_phone_names_json(name)
    func_name = "#{method(__method__).owner}.#{__method__}('#{name}')"
    Rails.logger.debug("#{func_name}...")
    uri = URI.escape("#{VERSUS_URL}/object?q=#{name}")
    json = JSON.parse(open(uri).read)
    sorted = json.sort_by { |a| Levenshtein.distance(a['name'], name) }
    Rails.logger.debug("#{func_name} -> #{sorted}")
    sorted
  end

  def get_phone_data(name_url)
    func_name = "#{method(__method__).owner}.#{__method__}('#{name_url}')"
    Rails.logger.debug("#{func_name}...")

    phone_data = {
      name: t(:unknown),
      points: -1,
      url: URI.escape("https://versus.com/en/#{name_url}"),
      vs_url: VERSUS_URL_WITH_TO_PHONE + name_url,
      price: nil
    }

    driver = create_driver("driver#{name_url}")

    begin
      set_name(driver, phone_data)
      set_points(driver, phone_data)
    ensure
      driver.quit
    end

    Rails.logger.debug("#{func_name} -> #{phone_data}")
    phone_data
  end

  def get_dummy_data(name)
    {
      name: name,
      points: -1,
      url: nil,
      vs_url: nil,
      price: nil
    }
  end

  def get_phone_data_with_name(name)
    name = name.strip
    func_name = "#{method(__method__).owner}.#{__method__}('#{name}')"
    Rails.logger.debug("#{func_name}...")
    data = get_dummy_data(name)
    json_name = get_phone_names_json(name)
    unless json_name.empty?
      name_url = json_name.first['name_url']
      data = get_phone_data(name_url)
    end
    Rails.logger.debug("#{func_name} -> #{data}")
    data
  end

  private

  def create_driver(app)
    service = Selenium::WebDriver::Service.chrome(
      path: "#{ENV['DRIVER_FOLDER']}/chromedriver"
    )
    opts = Selenium::WebDriver::Chrome::Options.new
    chrome_args = %w[--headless --window-size=1920,1080]
    chrome_args.each { |a| opts.add_argument(a) }
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: opts,
      service: service
    )
  end

  def set_name(driver, data)
    url = data[:url]
    selector = '.nameContainer p'
    driver.visit(url)
    # driver.save_screenshot('/tmp/1.png')
    names = driver.find_css(selector)
    data[:name] = names[0].visible_text.strip unless names.empty?
    if names.empty?
      Rails.logger.warn(
        "Name not found, page: #{url}, selector: #{selector}"
      )
    end
  end

  def set_points(driver, data)
    url = data[:url]
    selector = '#root .score .pointsText'
    driver.visit(url)
    points = driver.find_css(selector)
    data[:points] = points[0].visible_text.scan(/\d+/).join('').to_i \
                    unless points.empty?

    if points.empty?
      Rails.logger.warn(
        "Points not found, page: #{url}, selector: #{selector}"
      )
    end
  end
end
