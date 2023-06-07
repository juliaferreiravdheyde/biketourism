Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :routes, except: :destroy do
    resources :points, only: :create
    resources :favorites, only: :create
    resources :rides, only: %i[new create]
  end
  resources :favorites, only: %i[index destroy]
  resources :rides, only: :index

  get '/test', to: 'pages#test'
  # Defines the root path route ("/")
  # root "articles#index"
end
