Rails.application.routes.draw do
  get 'amazon/:phone_name' => 'amazon#get_price'
  get 'versuscom/:phone_name' => 'versus_com#get_points', defaults: { :format => 'json' }

  get 'phones/index'
  get 'phones/compare'

  root to: 'phones#index'
end
