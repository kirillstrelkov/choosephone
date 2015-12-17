require 'json'
require 'nokogiri'
require 'open-uri'

module PhonesHelper
  include VersusComHelper
  DEFAULT_TITLE = "Choose best phone between several ones"
  DEFAULT_DESC = "If you are tired of comparing multiple phones' features and don't know which one to choose. This site will try to help you by sorting entered phones using their points/scores. Most of modern phone vedors are supported like: sony, lg, samsung, apple, nokia and etc. Functionality is based on http://www.versus.com/ web site."
  DESC_PREFIX = "Which is the best phone?"

  def get_all_phones(phone_names)
    phone_names.uniq.map do |phone_name|
      get_phone_data_with_name(phone_name, load_points=false)
    end.sort { |a, b| - (a[:points] <=> b[:points]) }.uniq
  end

  def show_price(price)
    price.is_a?(String) && price.match(/.?\d+\.\d+/) ? price : 'Loading...'
  end

  def show_points(points)
    points.is_a?(String) && points.match(/\d+/) ? points : 'Loading...'
  end
end
