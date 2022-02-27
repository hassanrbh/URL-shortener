Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  # User Controller
  get 'user/:user_id', to: 'user#show'
  get 'user', to: 'user#index'
  post 'user', to: 'user#create'
  # Silly Controller
  get 'silly' , to: 'silly#fun'
  post 'silly', to: 'silly#aya'
end
