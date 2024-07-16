Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  
  resources  :registration, only: [:new, :create]
  resource   :session
  resource   :password_reset 
  resource   :password
  
  get "products", to: 'products#index', as: "products_index"
  resources  :products
  # config/routes.rb
  resources :products do
    collection do
      get 'export_excel', to: 'products#export_excel'
    end
  end


  
 # resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
  root "main#index"

  # get "/articles", to: "articles#index"

  # # Defines the root path route ("/")
  # root "posts#index"
end
