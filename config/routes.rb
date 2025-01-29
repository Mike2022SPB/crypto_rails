Rails.application.routes.draw do
  devise_for :users
  root 'portfolio#index'
  get 'portfolio/index'

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  patch 'add_token_to_portfolio',                              to: 'portfolio#add_token_to_portfolio'
  patch 'update_token_amount',                                 to: 'portfolio#update_token_amount'
  patch 'remove_token',                                        to: 'portfolio#remove_token'
  get   'currency/:id',                                        to: 'portfolio#show_currency_prices',          as: 'show_currency_prices'
end
