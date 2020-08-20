Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/challenge', to: 'challenge#index', as: 'challenge'
  
  resources :affinities, only: [:index]
  resources :users, only: [:index]
end
