Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :routes do
    resources :points, only: :create
    resources :favorites, only: :create
    resources :rides, only: %i[new create] do
      member do
        patch :mark_as_done
      end
    end
    resources :pinned_routes, only: :create
  end
  resources :favorites, only: %i[index destroy]
  resources :rides, only: %i[index destroy]

  # get '/test', to: 'pages#test'
  get '/myroutes', to: 'routes#my_routes', as: :my_routes
  get '/routes/:id/record', to: 'routes#record', as: :record
  patch '/routes/:id/register', to: 'routes#register', as: :register
  delete '/photos/:id', to: 'routes#delete_image_attachment', as: :delete_route_photo
  # Defines the root path route ("/")
  # root "articles#index"
end
