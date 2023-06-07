Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :routes do
    resources :points, only: :create
    resources :favorites, only: :create
    resources :rides, only: %i[new create]
    resources :pinned_routes, only: :create
  end
  resources :favorites, only: %i[index destroy]
  resources :rides, only: :index

  get '/test', to: 'pages#test'
  get '/routes/:id/record', to: 'routes#record', as: :record
  patch '/routes/:id/register', to: 'routes#register', as: :register
  # Defines the root path route ("/")
  # root "articles#index"
end
