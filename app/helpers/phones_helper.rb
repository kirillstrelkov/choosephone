module PhonesHelper
  include VersusComHelper

  def get_all_phones(phone_names)
    phone_names.map do |phone_name|
      get_dummy_data(phone_name)
    end
  end

  def show_price(price)
    price.is_a?(String) && price.match(/.?\d+\.\d+/) ? price : t(:loading)
  end

  def show_points(points)
    points.is_a?(String) && points.match(/\d+/) ? points : t(:loading)
  end

  def language_link(locale)
    if request.query_string.length > 0
      phones_compare_path(locale: locale) + '?' + request.query_string
    else
      index_path(locale: locale)
    end
  end
end
