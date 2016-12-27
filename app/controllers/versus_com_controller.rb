class VersusComController < ApplicationController
  include VersusComHelper
  include RedisHelper

  def points
    data = get_data(:versus, params[:phone_name])
    locale = I18n.locale
    data.each do |k, v|
      data[k] = v.gsub('/en/', "/#{locale}/") if k.to_s.include?('url')
    end
    render json: data
  end

  def price
    render json: get_data(:amazon, params[:phone_name])
  end

  private

  def get_data(prefix, name)
    data = get(prefix, name)
    unless data
      data = send(
        prefix == :amazon ? :get_price : :get_phone_data_with_name,
        name
      )
      condition = lambda do
        if prefix == :versus
          data[:points] > 0
        else
          data[:lowestPrice] && data[:lowestPrice].match(/.\d+[,\.]\d+$/)
        end
      end
      set(prefix, name, data) if condition.call
    end
    data
  end
end
