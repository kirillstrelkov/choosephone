require 'test_helper'

class AmazonHelperTest < ActionView::TestCase
  include AmazonHelper
  test "get_price should return json object for sony z3" do
    json_obj = AmazonHelper.get_price('sony xperia z3')
    assert_equal('$474.74', json_obj['lowestPrice'])
    assert_match(/^\$\d+\.\d+$/, json_obj['lowestPrice'])
    assert_not_nil(json_obj['url'])
  end
end
