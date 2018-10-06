require 'json'
require 'open-uri'
require 'levenshtein'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module VersusComHelper
  include Capybara::DSL

  VERSUS_URL = 'https://www.versus.com'.freeze
  VERSUS_URL_WITH_TO_PHONE = 'https://versus.com/en/samsung-galaxy-s9-plus-qualcomm-snapdragon-845-vs-'.freeze
  AMAZON_SEARCH_URL = 'https://versus.com/api/prices/pricetags/get'.freeze

  def get_price(phone_name)
    name_url = get_phone_names_json(phone_name).first['name_url']
    uri = URI.escape("#{AMAZON_SEARCH_URL}?name_url=#{name_url}&country=DE&type=vs")
    begin
      json_obj = JSON.parse(open(uri).read, symbolize_names: true)
      json_obj[:pricetags][0]
    rescue
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

    driver = Capybara::Poltergeist::Driver.new(
      "driver#{name_url}", js_errors: false
    )

    # driver.visit('http://github.com/')
    driver.save_screenshot('/tmp/1.png')

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
    func_name = "#{method(__method__).owner}.#{__method__}('#{name}')"
    Rails.logger.debug("#{func_name}...")
    name.strip!
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

  def set_name(driver, data)
    url = data[:url]
    selector = 'div[class*=rivalName]'
    driver.visit(url)
    driver.save_screenshot('/tmp/1.png')
    names = driver.find_css(selector)
    data[:name] = names[0].visible_text.strip unless names.empty?
    Rails.logger.warn(
      "Name not found, page: #{url}, selector: #{selector}"
    ) if names.empty?
  end

  def set_points(driver, data)
    url = data[:url]
    selector = '.aboveChart .points .absolute'
    driver.visit(url)
    points = driver.find_css(selector)
    data[:points] = points[0].visible_text.scan(/\d+/).join('').to_i \
                    unless points.empty?

    Rails.logger.warn(
      "Points not found, page: #{url}, selector: #{selector}"
    ) if points.empty?
  end
end
