class VersusComController < ApplicationController
  include VersusComHelper
  def get_points
    render json: VersusComHelper.get_phone_data_with_name(params[:phone_name])
  end
end
