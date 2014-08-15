require 'spec_helper'

describe PhonesController do

  describe "GET 'compare'" do
    it "returns http success" do
      get 'compare'
      expect(response).to redirect_to :action => :index
    end
  end

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      expect(response).to redirect_to :action => :index
    end
    
    it "should return found 'LG optimus L9' phone" do
      get 'search', {:q => 'lg optimus l9', :format => :json}
      phones = assigns(:phones).map {|p| p[:name]}
      expect(phones).to include("LG Optimus L9", "LG Optimus L9 II")
      expect(response.content_type).to eq('application/json')
    end
  end
  
  describe "GET 'data'" do
    it "should return data for url 'lg-optimus-l9'" do
      get 'data', {:name_url => 'lg-optimus-l9', :format => :json}
      phone_data = assigns(:phone_data)
      expect(phone_data[:name]).to eq 'LG Optimus L9'
      expect(phone_data[:points]).to be >= 8300
      expect(response.content_type).to eq 'application/json'
    end
  end
  
  describe "GET 'compare'" do
    it "should return phone for query 'lg optimus l9'" do
      post 'compare', {:phones => 'lg optimus l9'}
      phone = assigns(:phones)[0]
      expect(phone).not_to be_nil
      expect(phone[:name]).to eq 'LG Optimus L9'
      expect(phone[:points]).to be >= 8300
    end
  end
end
