require 'rails_helper'

RSpec.describe AmazonController, type: :controller do
  describe 'GET #price' do
    context 'for good name' do
      it 'returns correct object' do
        get :price, phone_name: 'sony xperia z3 compact', format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        expect(json).to include('url')
        expect(json).to include('lowestPrice')
        expect(json['lowestPrice']).to match(/\$\d+\.\d+/)
      end
    end

    context 'for bad name' do
      it 'retuns bad object' do
        get :price, phone_name: 'zx345345cvbnm', format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        expect(json).not_to include('url')
        expect(json).not_to include('lowestPrice')
      end
    end
  end
end
