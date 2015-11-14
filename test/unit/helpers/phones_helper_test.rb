require 'test_helper'

class PhonesHelperTest < ActionView::TestCase
  include PhonesHelper
  
  test "top phone is lg g4 h818n and versus_url_with_top_phone is correct" do
    url = 'http://versus.com/en/phone/top'
    
    doc = Nokogiri::HTML(open(url))
    name = doc.css('#winnerName #name').text.strip.gsub(' ', '-').downcase
    assert_includes PhonesHelper::VERSUS_URL_WITH_TO_PHONE, name
  end
  
  test "get_phone_names_json" do
    json_obj = PhonesHelper.get_phone_names_json 'sony xperia z3'
    assert json_obj.length > 0
    assert_equal json_obj[0], {"name"=>"Sony Xperia Z3", "name_url"=>"sony-xperia-z3"}
  end
  
  test "get_phone_data" do 
    obj = PhonesHelper.get_phone_data 'sony-xperia-z3'
    assert_not_nil obj
    assert_equal obj[:name], "Sony Xperia Z3"
    assert_equal obj[:url], "http://versus.com/en/sony-xperia-z3"
    assert_equal obj[:vs_url], "http://versus.com/en/sony-xperia-z5-premium-dual-vs-sony-xperia-z3"
    assert obj[:points] > 24000, "Incorrect number of points: #{obj[:points]}"
  end
  
  test "get_phone_data_with_name" do
    obj = PhonesHelper.get_phone_data_with_name 'sony xperia z3'
    assert_not_nil obj
    assert_equal obj[:name], "Sony Xperia Z3"
    assert_equal obj[:url], "http://versus.com/en/sony-xperia-z3"
    assert_equal obj[:vs_url], "http://versus.com/en/sony-xperia-z5-premium-dual-vs-sony-xperia-z3"
    assert obj[:points] > 24000, "Incorrect number of points: #{obj[:points]}"
  end
  
  test "get_all_phones" do
    phones = PhonesHelper.get_all_phones ['sony z3', 'sony z2']
    assert_equal phones.length, 2
    assert_equal phones[0][:name], 'Sony Xperia Z3'
    assert_equal phones[1][:name], 'Sony Xperia Z2'
  end
end
