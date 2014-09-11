require 'json'
require 'nokogiri'
require 'open-uri'


module PhonesHelper
  @@url = 'http://www.versus.com'
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

    uri = URI.encode("#{@@url}/en/#{name_url}")
    doc = Nokogiri::HTML(open(uri))

    name = doc.xpath("//div[@id='stage']/div[1]/h1/text()")[0].to_s
    points = doc.xpath("//div[@id='stage']/div[1]/h2/text()")[0].to_s
    values = [name]
    values += [/\d+/.match(points)[0].to_i]
    values += [uri]
    attributes += doc.xpath("//div[@class='prop']/div[@class='info']/text()").map{|e| e.to_s}
    values += doc.xpath("//div[@class='prop']/div[@class='value']/text()").map{|e| e.to_s}

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
