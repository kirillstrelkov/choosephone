Rails.application.routes.draw do
  get 'versuscom/:phone_name/price' => 'versus_com#price', defaults: { format: 'json' }

  scope ':locale', locale: /en|ru/ do
    get '' => 'phones#index'
    get 'index' => 'phones#index'
    get 'phones/index'
    get 'phones/compare'
    get 'versuscom/:phone_name/points' => 'versus_com#points', defaults: { format: 'json' }
  end

  root to: redirect("/#{I18n.default_locale}")
  get 'phones/*page', to: redirect { |path_params, req|
    if req.query_string.length > 0
      "/#{I18n.default_locale}/phones/#{path_params[:page]}?#{req.query_string}"
    else
      "/#{I18n.default_locale}/phones/#{path_params[:page]}"
    end
  }
end
