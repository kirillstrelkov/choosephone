require 'test_helper'

class AmazonControllerTest < ActionController::TestCase
  test "should return json object for sony z3" do
    get 'get_price', :phone_name => 'sony xperia z3', :format => 'json'
    assert_response :success
    json = JSON.parse(@response.body)
    assert_includes json, 'lowestPrice'
    assert_match(/^\$\d+\.\d+$/, json['lowestPrice'])
    assert_includes json, 'url'
    assert_match(/^http:\/\/.+$/, json['url'])
  end
end
