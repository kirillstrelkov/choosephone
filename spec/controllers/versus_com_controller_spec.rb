require 'rails_helper'

RSpec.describe VersusComController, type: :controller do
  describe 'GET #points' do
    context 'for good name' do
      it 'returns currect object' do
        get :points, phone_name: 'sony xperia z3', locale: :en, format: 'json'
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

      it 'returns correct object for ENG locale' do
        get :points, phone_name: 'sony xperia z3', locale: :en, format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        data = JSON.parse(response.body)
        expect(data).to include('name')
        expect(data).to include('points')
        expect(data).to include('url')
        expect(data['url']).to include('/en/')
        expect(data).to include('vs_url')
        expect(data['vs_url']).to include('/en/')
        expect(data['points']).to be > 0
        expect(data['price']).to be_nil
      end

      it 'returns correct object for RU locale' do
        get :points, phone_name: 'sony xperia z3', locale: :ru, format: 'json'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        data = JSON.parse(response.body)
        expect(data).to include('name')
        expect(data).to include('points')
        expect(data).to include('url')
        expect(data['url']).to include('/ru/')
        expect(data).to include('vs_url')
        expect(data['vs_url']).to include('/ru/')
        expect(data['points']).to be > 0
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
        expect(data['lowestPrice']).to match(/[\$€]\d+[,\.]\d+/)
      end
    end
  end
end
