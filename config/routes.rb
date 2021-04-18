Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin_api do
    post 'authenticate', to: 'authentication#authenticate'

    resources :clients, only: [:index]
    resources :notifications, only: [:index, :show, :create]
    resources :notification_assignments, only: [:create]

  end

  namespace :client_api do
    post 'authenticate', to: 'authentication#authenticate'
    get '/investment_portfolio', to: 'investment_portfolio#show'

    resources :notifications, only: [:index]
  end
end
