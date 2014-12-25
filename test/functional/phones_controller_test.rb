require 'test_helper'

class PhonesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "should get compare" do
    get :compare
    assert_redirected_to :action => :index
  end
end
