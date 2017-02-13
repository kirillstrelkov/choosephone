require 'json'
require 'open-uri'
require 'levenshtein'
require 'capybara'
require 'capybara/poltergeist'

module VersusComHelper
  include RedisHelper
  include Capybara::DSL

  VERSUS_URL = 'https://www.versus.com'
  VERSUS_URL_WITH_TO_PHONE = 'https://versus.com/en/sony-xperia-z5-premium-dual-vs-'
  AMAZON_SEARCH_URL = 'https://versus.com/pricetags/get'

  def get_price(phone_name)
    uri = URI.encode("#{AMAZON_SEARCH_URL}?keywords=#{phone_name}")
    begin
      json_obj = JSON.parse(open(uri).read, symbolize_names: true)
      json_obj[:pricetags][0]
    rescue
      { error: t(:unknown_error_occurred) }
    end
  end

  def get_phone_names_json(name)
    uri = URI.encode("#{VERSUS_URL}/object?q=#{name}")
    json = JSON.parse(open(uri).read)
    json.sort_by { |a| Levenshtein.distance(a['name'], name) }
  end

  def get_phone_data(name_url, load_points=true)
    uri = URI.encode('https://versus.com/en/' + name_url)
    versus_top_phone_url = VERSUS_URL_WITH_TO_PHONE + name_url
    phone_data = { name: t(:unknown),
                   points: -1,
                   url: uri,
                   vs_url: versus_top_phone_url,
                   price: nil }

    visit(uri)
    names = all(:css, 'div[class*=rivalName]')
    unless names.empty?
      name = names[0].text.strip
      phone_data[:name] = name
    end

    phone_data[:points] = get_points if load_points

    phone_data
  end

  def get_phone_data_with_name(name, load_points = true)
    data = {
      name: name,
      points: -1,
      url: nil,
      vs_url: nil,
      price: nil
    }
    json_name = get_phone_names_json(name.strip)
    unless json_name.empty?
      name_url = json_name.first['name_url']
      data = get(:versus, name_url)
      data = get_phone_data(name_url, load_points) unless data
    end
    data
  end

  private

  def get_points
    times_for_found_points = 2
    same_times = 0
    points = 0
    cur_points = []
    10.times do
      begin
        cur_points = all(:css, 'div[class*=points] span[class*=ScoreChart]', minimum: 1)
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
      sleep(0.1)
    end
    points > 0 ? points : -1
  end
end
