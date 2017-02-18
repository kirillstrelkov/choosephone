require 'rails_helper'

RSpec.describe PhonesHelper, type: :helper do
  describe '#get_all_phones' do
    it 'should return json object for sony-xperia-z3' do
      json = get_all_phones(['sony z3', 'sony z2'])
      expect(json.length).to eq(2)
      expect(json[0][:name]).to eq('sony z3')
      expect(json[1][:name]).to eq('sony z2')
    end
  end
end
