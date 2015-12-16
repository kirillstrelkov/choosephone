require 'rails_helper'

RSpec.describe VersusComHelper, type: :helper do
  describe '#get_phone_names_json' do
    it 'should return suggestions for sony z3' do
      objects = VersusComHelper.get_phone_names_json('sony z3')
      expect(objects.length).to be > 0
      expect(objects.first['name']).to eq('Sony Xperia Z3')
      expect(objects.first['name_url']).to eq('sony-xperia-z3')
    end
  end

  describe '#get_phone_data' do
    it 'should return data for sony z3' do
      data = VersusComHelper.get_phone_data('sony-xperia-z3')
      expect(data[:name]).to eq('Sony Xperia Z3')
      expect(data[:points]).to be > 30_000
      expect(data[:url]).to match(/http:.+/)
      expect(data[:vs_url]).to match(/http:.+/)
    end
  end

  describe '#get_phone_data_with_name' do
    it 'should return data for sony z3' do
      data = VersusComHelper.get_phone_data_with_name('sony z3')
      expect(data[:name]).to eq('Sony Xperia Z3')
      expect(data[:points]).to be > 30_000
      expect(data[:url]).to match(/http:.+/)
      expect(data[:vs_url]).to match(/http:.+/)
    end
  end
end
