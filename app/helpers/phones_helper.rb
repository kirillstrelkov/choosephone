require 'json'
require 'nokogiri'
require 'open-uri'


module PhonesHelper
  @@url = 'http://www.versus.com'
  @@phone_url = "http://versus.com/en/%s"
  @@versus_vs = "http://versus.com/en/%s-vs-sony-xperia-z3"
  @@amazon_search = 'http://versus.com/amazon/search'
  DEFAULT_TITLE = "Choose best phone between several ones"
  DEFAULT_DESC = "If you are tired of comparing multiple phones' features and don't know which one to choose. This site will try to help you by sorting entered phones using their points/scores. Most of modern phone vedors are supported like: sony, lg, samsung, apple, nokia and etc. Functionality is based on http://www.versus.com/ web site."
  DESC_PREFIX = "Which is the best phone?"

  def self.amazon_search(phone_name)
    uri = URI.encode("#{@@amazon_search}?keywords=#{phone_name}&category=phone")
    JSON.parse(open(uri).read())
  end

  def self.get_phone_names_json(name)
    uri = URI.encode("#{@@url}/object?q=#{name}")
    JSON.parse(open(uri).read())
  end

  def self.get_phone_data(name_url)
    phone_data = Hash.new

    uri = URI.encode(@@phone_url % name_url)
    versus_top_phone_url = @@versus_vs % name_url
    doc = Nokogiri::HTML(open(URI.encode(versus_top_phone_url)))
    
    xpath_name = "//div[contains(@class, 'label-group')]//a[contains(@class, 'name')]/text()"
    xpath_points = "//div[contains(@class, 'label-group')]//a[contains(@class, 'points')]/text()"
    name = doc.xpath(xpath_name)[0].to_s
    points = doc.xpath(xpath_points)[0].to_s

    phone_data[:name] = name
    phone_data[:url] = uri
    phone_data[:vs_url] = versus_top_phone_url
    if /\d+/.match(points).nil?
      phone_data[:points] = 0
    else
      phone_data[:points] = /\d+/.match(points)[0].to_i
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
    phone_names.compact.map do |phone_name|
      self.get_phone_data_with_name(phone_name)
    end.sort {|a,b| - (a[:points] <=> b[:points])}.uniq
  end

end
