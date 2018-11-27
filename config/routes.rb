Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users, only: [:show]
  get 'profiles', to: 'profiles#show'
  #get    "users",          to: "users#profile"
  resources :flats  do
    resources :appointments
  end
end
