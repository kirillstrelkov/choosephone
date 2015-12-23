module PhonesHelper
  include VersusComHelper

  def get_all_phones(phone_names)
    phone_names.uniq.map do |phone_name|
      get_phone_data_with_name(phone_name, false)
    end.sort { |a, b| - (a[:points] <=> b[:points]) }.uniq
  end

  def show_price(price)
    price.is_a?(String) && price.match(/.?\d+\.\d+/) ? price : t(:loading)
  end

  def show_points(points)
    points.is_a?(String) && points.match(/\d+/) ? points : t(:loading)
  end

  def language_link(locale)
    # debugger
    if request.query_string.length > 0
      phones_compare_path(locale: locale) + '?' + request.query_string
    else
      index_path(locale: locale)
    end
  end
end
