require 'rails_helper'

RSpec.describe VersusComController, type: :controller do
  describe 'GET #points' do
    context 'for good name' do
      it 'returns currect object' do
        get :points, phone_name: 'sony xperia z3', format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        expect(json).to include('name')
        expect(json).to include('points')
        expect(json).to include('url')
        expect(json).to include('vs_url')
        expect(json['points']).to be > 0
        expect(json['price']).to be_nil
      end
    end

    context 'for bad name' do
      it 'returns bad object' do
        get :points, phone_name: 'a' * 20, format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        expect(json).to include('name')
        expect(json).to include('points')
        expect(json).to include('url')
        expect(json).to include('vs_url')
        expect(json['points']).to eq(-1)
        expect(json['price']).to be_nil
      end
    end
  end

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
        get :price, phone_name: 'a' * 20, format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        expect(json).not_to include('url')
        expect(json).not_to include('lowestPrice')
      end
    end
  end
end
