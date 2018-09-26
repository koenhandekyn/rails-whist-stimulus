Rails.application.routes.draw do
  resources :rounds
  resources :games
  root 'games#index'
  mount ActionCable.server => '/cable'
end
