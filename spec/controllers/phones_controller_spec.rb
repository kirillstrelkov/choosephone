require 'rails_helper'

RSpec.describe PhonesController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { locale: :en }
      expect(response).to have_http_status(:success)
      body = response.body
      expect(body).to have_css('.panel')
      expect(body).to have_css('textarea')
      expect(body).to have_css('#clear_btn')
      expect(body).to have_css('#search_btn')
      expect(body).to have_css('.thumbnail', count: 3)
    end
  end

  describe 'GET #compare' do
    context 'without parameters' do
      it 'redirects to index' do
        get :compare, params: { locale: :en }
        expect(response).to redirect_to(phones_index_url)
      end
    end
    context 'with parameters' do
      it 'returns http success' do
        get :compare, params: { locale: :en, phone_names: 'z1 compact, z3 compact' }
        expect(response).to have_http_status(:success)
        body = response.body
        expect(body).to have_css('tbody tr', count: 2)
        expect(body).to have_content('Loading...', count: 5)
        expect(body).to have_content('z1 compact')
        expect(body).to have_content('z3 compact')
      end
    end
  end
end
