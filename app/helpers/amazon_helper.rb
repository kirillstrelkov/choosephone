module AmazonHelper
  @@amazon_search = 'http://versus.com/amazon/search'

  def self.get_price(phone_name)
    uri = URI.encode("#{@@amazon_search}?keywords=#{phone_name}&category=phone")
    JSON.parse(open(uri).read())
  end
end
