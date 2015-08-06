module AmazonHelper
  @@amazon_search = 'http://versus.com/pricetags/get'

  def self.get_price(phone_name)
    uri = URI.encode("#{@@amazon_search}?keywords=#{phone_name}")
    begin
      json_obj = JSON.parse(open(uri).read())
      json_obj['pricetags'][0]
    rescue
      {:error => "Unknown error occurred"}
    end
  end
end
