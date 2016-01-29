require 'rails_helper'

RSpec.describe VersusComHelper, type: :helper do
  describe 'top phone' do
    it 'should return top phone from versus.com' do
      doc = Nokogiri::HTML(open('https://versus.com/en/phone/top'))
      name = doc.css('#winnerName #name').text.strip.gsub(/\s+/, '-').downcase
      expect(VersusComHelper::VERSUS_URL_WITH_TO_PHONE).to include(name)
    end
  end

  describe '#get_phone_names_json' do
    it 'should return suggestions for sony z3' do
      objects = get_phone_names_json('sony z3')
      expect(objects.length).to be > 0
      expect(objects.first['name']).to eq('Sony Xperia Z3')
      expect(objects.first['name_url']).to eq('sony-xperia-z3')
    end
  end

  describe '#get_phone_data' do
    it 'should return data for sony z3' do
      data = get_phone_data('sony-xperia-z3')
      expect(data[:name]).to eq('Sony Xperia Z3')
      expect(data[:points]).to be > 30_000
      expect(data[:url]).to eq('https://versus.com/en/sony-xperia-z3')
      expect(data[:vs_url]).to eq('https://versus.com/en/sony-xperia-z5-premium-dual-vs-sony-xperia-z3')
      expect(data[:price]).to be_nil
    end
  end

  describe '#get_phone_data_with_name' do
    it 'should return data for sony z3' do
      data = get_phone_data_with_name('sony z3')
      expect(data[:name]).to eq('Sony Xperia Z3')
      expect(data[:points]).to be > 30_000
      expect(data[:url]).to eq('https://versus.com/en/sony-xperia-z3')
      expect(data[:vs_url]).to eq('https://versus.com/en/sony-xperia-z5-premium-dual-vs-sony-xperia-z3')
    end
  end

  describe '#get_price' do
    it 'should return proper json object for sony z3' do
      data = get_price('sony xperia z3')
      expect(data[:lowestPrice]).to match(/\$\d+\.\d+/)
      expect(data).to include(:url)
    end
  end
end
