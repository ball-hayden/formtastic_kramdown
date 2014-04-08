Rails.application.routes.draw do
  mount FormtasticKramdown::Engine, at: '/'

  root 'home#index'

  resources :test_models
end
