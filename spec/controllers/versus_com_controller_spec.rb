require 'rails_helper'

RSpec.describe VersusComController, type: :controller do
  describe 'GET #points' do
    it 'returns http success' do
      get :points, phone_name: 'sony xperia z3', format: 'json'
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json')
      json = JSON.parse(response.body)
      expect(json).to include('name')
      expect(json).to include('points')
      expect(json).to include('url')
      expect(json).to include('vs_url')
      expect(json['points']).to be > 0
    end
  end
end
