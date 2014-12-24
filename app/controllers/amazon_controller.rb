class AmazonController < ApplicationController
  include AmazonHelper

  def get_price
    name = params['phone_name']
    if name.nil?
      data = {}
    else
      data = AmazonHelper.get_price(name)
    end
    respond_to do |format|
      format.json {render :json => data}
    end
  end
end
