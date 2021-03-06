Rails.application.routes.draw do
  get 'passwords/edit'

  root 'static_pages#home'
  get '/stats', to: 'static_pages#stats'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, path: :members do
    resource :account_activation, path: :activation, as: :activation
    resource :password, only: %i(edit update)
    resource :admin, only: %i(create destroy)
  end
  resources :password_resets, only: %i(new create edit update)
  resources :lives
  resources :songs
end
