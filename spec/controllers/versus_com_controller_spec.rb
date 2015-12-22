require 'rails_helper'

RSpec.describe VersusComController, type: :controller do
  describe 'GET #points' do
    context 'for good name' do
      it 'returns currect object' do
        get :points, phone_name: 'sony xperia z3', format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        data = JSON.parse(response.body)
        expect(data).to include('name')
        expect(data).to include('points')
        expect(data).to include('url')
        expect(data).to include('vs_url')
        expect(data['points']).to be > 0
        expect(data['price']).to be_nil
      end
    end

    context 'for bad name' do
      it 'returns bad object' do
        get :points, phone_name: 'a' * 20, format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        data = JSON.parse(response.body)
        expect(data).to include('name')
        expect(data).to include('points')
        expect(data).to include('url')
        expect(data).to include('vs_url')
        expect(data['points']).to eq(-1)
        expect(data['price']).to be_nil
      end
    end
  end

  describe 'GET #price' do
    context 'for good name' do
      it 'returns correct object' do
        get :price, phone_name: 'sony xperia z3 compact', format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        data = JSON.parse(response.body)
        expect(data).to include('url')
        expect(data).to include('lowestPrice')
        expect(data['lowestPrice']).to match(/\$\d+\.\d+/)
      end
    end

    context 'for bad name' do
      it 'retuns bad object' do
        get :price, phone_name: 'a' * 20, format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        data = JSON.parse(response.body)
        expect(data).not_to include('url')
        expect(data).not_to include('lowestPrice')
      end
    end
  end
end
