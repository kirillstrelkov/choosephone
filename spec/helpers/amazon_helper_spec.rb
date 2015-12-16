require 'rails_helper'

RSpec.describe AmazonHelper, type: :helper do
  include AmazonHelper
  describe '#get_price' do
    it 'should return proper json object for sony z3' do
      json = AmazonHelper.get_price('sony xperia z3')
      expect(json[:lowestPrice]).to match(/\$\d+\.\d+/)
      expect(json).to include(:url)
    end
  end
end
