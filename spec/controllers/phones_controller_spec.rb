require 'rails_helper'

RSpec.describe PhonesController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'returns http success' do
      get :index
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
      it 'returns http success' do
        get :compare
        expect(response).to redirect_to(phones_index_url)
      end
    end
    context 'with parameters' do
      it 'returns http success' do
        get :compare, phone_names: 'z1 compact, z3 compact'
        expect(response).to have_http_status(:success)
        body = response.body
        expect(body).to have_css('tbody tr', count: 2)
        expect(body).to have_content('Loading...', count: 4)
        expect(body).to have_content('Sony Xperia Z3 Compact')
        expect(body).to have_content('Sony Xperia Z1 Compact')
        expect(body.index('Sony Xperia Z1 Compact'))
          .to be < body.index('Sony Xperia Z3 Compact')
      end
    end
  end
end
