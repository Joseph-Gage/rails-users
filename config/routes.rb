Rails.application.routes.draw do
  root   'sessions#new'

  get    '/signin',  to: 'sessions#new'
  post   '/signin',  to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  resources :users
end
