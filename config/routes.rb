Rails.application.routes.draw do
  get 'versuscom/:phone_name/price' => 'versus_com#price', defaults: { format: 'json' }
  get 'versuscom/:phone_name/points' => 'versus_com#points', defaults: { format: 'json' }

  get 'phones/index'
  get 'phones/compare'

  root to: 'phones#index'
end
