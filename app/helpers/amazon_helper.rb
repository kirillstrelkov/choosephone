module AmazonHelper
  AMAZON_SEARCH_URL = 'http://versus.com/pricetags/get'

  def self.get_price(phone_name)
    uri = URI.encode("#{AMAZON_SEARCH_URL}?keywords=#{phone_name}")
    begin
      json_obj = JSON.parse(open(uri).read, symbolize_names: true)
      json_obj[:pricetags][0]
    rescue
      { error: 'Unknown error occurred' }
    end
  end
end
