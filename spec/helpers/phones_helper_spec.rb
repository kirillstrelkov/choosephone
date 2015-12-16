require 'rails_helper'

RSpec.describe PhonesHelper, type: :helper do
  describe 'top phone' do
    it 'should return top phone from versus.com' do
      doc = Nokogiri::HTML(open('http://versus.com/en/phone/top'))
      name = doc.css('#winnerName #name').text.strip.gsub(/\s+/, '-').downcase
      expect(PhonesHelper::VERSUS_URL_WITH_TO_PHONE).to include(name)
    end
  end

  describe '#get_phone_names_json' do
    it 'should return json object for sony xperia z3' do
      json = PhonesHelper.get_phone_names_json('sony xperia z3')
      expect(json.length).to be > 0
      expect(json[0]).to eq('name' => 'Sony Xperia Z3',
                            'name_url' => 'sony-xperia-z3')
    end
  end

  describe '#get_phone_data' do
    it 'should return json object for sony-xperia-z3' do
      json = PhonesHelper.get_phone_data('sony-xperia-z3')
      expect(json[:name]).to eq('Sony Xperia Z3')
      expect(json[:url]).to eq('http://versus.com/en/sony-xperia-z3')
      expect(json[:vs_url]).to eq('http://versus.com/en/sony-xperia-z5-premium-dual-vs-sony-xperia-z3')
      expect(json[:points]).to eq(-1)
      expect(json[:price]).to be_nil
    end
  end

  describe '#get_phone_data_with_name' do
    it 'should return json object for sony-xperia-z3' do
      json = PhonesHelper.get_phone_data_with_name('sony xperia z3')
      expect(json[:name]).to eq('Sony Xperia Z3')
      expect(json[:url]).to eq('http://versus.com/en/sony-xperia-z3')
      expect(json[:vs_url]).to eq('http://versus.com/en/sony-xperia-z5-premium-dual-vs-sony-xperia-z3')
      expect(json[:points]).to eq(-1)
      expect(json[:price]).to be_nil
    end
  end

  describe '#get_all_phones' do
    it 'should return json object for sony-xperia-z3' do
      json = PhonesHelper.get_all_phones ['sony z3', 'sony z2']
      expect(json.length).to eq(2)
      expect(json[0][:name]).to eq('Sony Xperia Z3')
      expect(json[1][:name]).to eq('Sony Xperia Z2')
    end
  end
end
