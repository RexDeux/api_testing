Rails.application.routes.draw do
  root 'pages#home'

  get '/categories', to: 'categories#index', as: 'categories'

  resources :books
  resources :categories, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
