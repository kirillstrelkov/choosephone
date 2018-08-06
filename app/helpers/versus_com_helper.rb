require 'json'
require 'open-uri'
require 'levenshtein'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module VersusComHelper
  include Capybara::DSL

  VERSUS_URL = 'https://www.versus.com'.freeze
  VERSUS_URL_WITH_TO_PHONE = 'https://versus.com/en/sony-xperia-z5-premium-dual-vs-'.freeze
  AMAZON_SEARCH_URL = 'https://versus.com/pricetags/get'.freeze

  def get_price(phone_name)
    uri = URI.escape("#{AMAZON_SEARCH_URL}?keywords=#{phone_name}")
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
    driver.visit(data[:url])
    names = driver.find_css('div[class*=rivalName]')
    data[:name] = names[0].visible_text.strip unless names.empty?
  end

  def set_points(driver, data)
    points = driver.find_css('div[class*=points] span[class*=ScoreChart]')
    data[:points] = points[0].visible_text.scan(/\d+/).join('').to_i \
                    unless points.empty?
  end
end
