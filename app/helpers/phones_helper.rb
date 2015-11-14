require 'json'
require 'nokogiri'
require 'open-uri'


module PhonesHelper
  VERSUS_URL = 'http://www.versus.com'
  PHONE_URL = "http://versus.com/en/%s"
  VERSUS_URL_WITH_TO_PHONE = "http://versus.com/en/sony-xperia-z5-premium-dual-vs-%s"
  DEFAULT_TITLE = "Choose best phone between several ones"
  DEFAULT_DESC = "If you are tired of comparing multiple phones' features and don't know which one to choose. This site will try to help you by sorting entered phones using their points/scores. Most of modern phone vedors are supported like: sony, lg, samsung, apple, nokia and etc. Functionality is based on http://www.versus.com/ web site."
  DESC_PREFIX = "Which is the best phone?"

  def self.get_phone_names_json(name)
    uri = URI.encode("#{VERSUS_URL}/object?q=#{name}")
    JSON.parse(open(uri).read())
  end

  def self.get_phone_data(name_url)
    uri = URI.encode(PHONE_URL % name_url)
    versus_top_phone_url = VERSUS_URL_WITH_TO_PHONE % name_url
    phone_data = {:name => 'Unknown',
                  :points => -1,
                  :url => uri,
                  :vs_url => versus_top_phone_url}

    doc = Nokogiri::HTML(open(URI.encode(uri)))
    
    names = doc.css('.title')
    unless names.empty?
      name = names[0].text.strip
      phone_data[:name] = name
    end
    
    points = doc.css('.points-text')
    unless points.empty?
      points = points[0].text.strip
      unless /\d+/.match(points).nil?
        phone_data[:points] = /\d+/.match(points)[0].to_i
      end
    end

    phone_data
  end

  def self.get_phone_data_with_name(name)
    object = self.get_phone_names_json(name.strip)
    if !object.nil? && !object.empty?
      self.get_phone_data(object[0]['name_url'])
    end
  end

  def self.get_all_phones(phone_names)
    phone_names.uniq.map do |phone_name|
      self.get_phone_data_with_name(phone_name)
    end.sort {|a,b| - (a[:points] <=> b[:points])}.uniq
  end

end
