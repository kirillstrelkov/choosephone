class VersusComController < ApplicationController
  include VersusComHelper
  include RedisHelper

  def points
    name = params[:phone_name]
    data = get(:versus, name)
    unless data
      data = VersusComHelper.get_phone_data_with_name(name)
      set(:versus, name, data) if data[:points] > 0
    end
    render json: data
  end
end
