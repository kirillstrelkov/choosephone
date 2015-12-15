class AmazonController < ApplicationController
  include AmazonHelper
  include RedisHelper

  def price
    name = params[:phone_name]
    data = get(:amazon, name)
    unless data
      data = AmazonHelper.get_price(name)
      set(:amazon, name, data)
    end
    render json: data
  end
end
