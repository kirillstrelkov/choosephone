require 'json'
require 'nokogiri'
require 'open-uri'
require 'capybara'
require 'capybara/poltergeist'

module VersusComHelper
  extend Capybara::DSL

  VERSUS_URL = 'http://www.versus.com'
  PHONE_URL = "http://versus.com/en/%s"
  VERSUS_URL_WITH_TO_PHONE = "http://versus.com/en/sony-xperia-z5-premium-dual-vs-%s"
  DEFAULT_TITLE = "Choose best phone between several ones"
  DEFAULT_DESC = "If you are tired of comparing multiple phones' features and don't know which one to choose. This site will try to help you by sorting entered phones using their points/scores. Most of modern phone vedors are supported like: sony, lg, samsung, apple, nokia and etc. Functionality is based on http://www.versus.com/ web site."
  DESC_PREFIX = "Which is the best phone?"

  def self.get_phone_names_json(name)
    uri = URI.encode("#{VERSUS_URL}/object?q=#{name}")
    JSON.parse(open(uri).read)
  end

  def self.get_phone_data(name_url)
    uri = URI.encode(PHONE_URL % name_url)
    versus_top_phone_url = VERSUS_URL_WITH_TO_PHONE % name_url
    phone_data = { name: 'Unknown',
                   points: -1,
                   url: uri,
                   vs_url: versus_top_phone_url }

    visit(uri)
    names = all(:css, '.title')
    unless names.empty?
      name = names[0].text.strip
      phone_data[:name] = name
    end

    phone_data[:points] = get_points

    phone_data
  end

  def self.get_phone_data_with_name(name)
    object = get_phone_names_json(name.strip)
    if !object.nil? && !object.empty?
      self.get_phone_data(object[0]['name_url'])
    end
  end

  private

  def self.get_points
    times_for_found_points = 3
    same_times = 0
    points = 0
    cur_points = []
    10.times do
      begin
        cur_points = all(:css, '.points-text', minimum: 1)
      rescue Capybara::CapybaraError => e
        cur_points = []
      end

      unless cur_points.empty?
        cur_points = cur_points[0].text.scan(/\d+/).join('').to_i
        if points == cur_points && points != 0
          same_times += 1
        else
          same_times = 0
        end
        points = cur_points
      end
      break if points > 0 && same_times == times_for_found_points
      sleep(0.5)
    end
    points > 0 ? points : -1
  end
end
