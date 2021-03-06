# frozen_string_literal: true

class VersusComController < ApplicationController
  include VersusComHelper
  include RedisHelper

  def points
    func_name = "#{method(__method__).owner}.#{__method__}()"
    Rails.logger.debug("#{func_name}...")

    data = get_data(:versus, params[:phone_name])
    locale = I18n.locale
    if data[:points] != -1
      data.each do |k, v|
        data[k] = v.gsub('/en/', "/#{locale}/") if k.to_s.include?('url')
      end
    end

    Rails.logger.debug("#{func_name} -> #{data}")

    render json: data
  end

  def price
    func_name = "#{method(__method__).owner}.#{__method__}()"
    Rails.logger.debug("#{func_name}...")

    data = get_data(:amazon, params[:phone_name])

    Rails.logger.debug("#{func_name} -> #{data}")

    render json: data
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
          data[:points].positive?
        else
          data[:lowestPrice]&.match(/.\d+[,.]\d+$/)
        end
      end
      set(prefix, name, data) if condition.call
    end
    data
  end
end
