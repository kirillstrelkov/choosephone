Rails.application.routes.draw do
  get 'amazon/:phone_name' => 'amazon#price', defaults: { format: 'json' }
  get 'versuscom/:phone_name' => 'versus_com#points', defaults: { format: 'json' }

  get 'phones/index'
  get 'phones/compare'

  root to: 'phones#index'
end
