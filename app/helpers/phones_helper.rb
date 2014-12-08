require 'json'
require 'nokogiri'
require 'open-uri'


module PhonesHelper
  @@url = 'http://www.versus.com'
  @@phone_url = "http://versus.com/en/%s"
  @@versus_vs = "http://versus.com/en/%s-vs-sony-xperia-z3"
  @@amazon_search = 'http://versus.com/amazon/search'

  def self.amazon_search(phone_name)
    uri = URI.encode("#{@@amazon_search}?keywords=#{phone_name}&category=phone")
    JSON.parse(open(uri).read())
  end

  def self.get_phone_names_json(name)
    uri = URI.encode("#{@@url}/object?q=#{name}")
    JSON.parse(open(uri).read())
  end

  def self.get_phone_data(name_url)
    attributes = ['name', 'points', 'url']

    uri = URI.encode(@@phone_url % name_url)
    doc = Nokogiri::HTML(open(URI.encode(@@versus_vs % name_url)))
    
    xpath_name = "//div[contains(@class, 'label-group')]//a[contains(@class, 'name')]/text()"
    xpath_points = "//div[contains(@class, 'label-group')]//a[contains(@class, 'points')]/text()"
    name = doc.xpath(xpath_name)[0].to_s
    points = doc.xpath(xpath_points)[0].to_s
    values = [name]
    values += [/\d+/.match(points)[0].to_i]
    values += [uri]
    #attributes += doc.xpath("//div[@class='prop']/div[@class='info']/text()").map{|e| e.to_s}
    #values += doc.xpath("//div[@class='prop']/div[@class='value']/text()").map{|e| e.to_s}

    Hash[attributes.zip values]
  end

  def self.get_phone_data_with_name(name)
    object = self.get_phone_names_json(name.strip)
    if !object.nil? && !object.empty?
      self.get_phone_data(object[0]['name_url'])
    end
  end

  def self.get_all_phones(phone_names)
    phone_names.map do |phone_name|
      self.get_phone_data_with_name(phone_name)
    end.sort {|a,b| - (a['points'] <=> b['points'])}.compact
  end

end
