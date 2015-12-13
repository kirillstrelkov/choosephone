require 'test_helper'

class VersusComControllerTest < ActionController::TestCase
  test 'should return json with name and points' do
    get 'get_points', phone_name: 'z1 compact', format: :json
    assert_response :success
    json = JSON.parse(@response.body)
    assert_includes(json, :name)
    assert_includes(json, :points)
    assert_match(/\d+/, json[:points])
  end
end
