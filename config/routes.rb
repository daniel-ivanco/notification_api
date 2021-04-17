Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin_api do
  end

  namespace :client_api do
    get '/investment_portfolio', to: 'investment_portfolio#show'
  end
end
