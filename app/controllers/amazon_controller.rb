class AmazonController < ApplicationController
  include AmazonHelper
  include RedisHelper

  def price
    name = params[:phone_name]
    data = get(:amazon, name)
    unless data
      data = AmazonHelper.get_price(name)
      set(:amazon, name, data) if data[:lowestPrice] &&
                                  data[:lowestPrice].match(/^\$\d+\.\d+$/)
    end
    render json: data
  end
end
