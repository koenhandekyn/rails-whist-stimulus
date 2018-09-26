Rails.application.routes.draw do
  resources :rounds
  resources :games
  root 'games#index'
end
