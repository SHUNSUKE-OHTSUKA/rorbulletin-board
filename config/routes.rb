Rails.application.routes.draw do
  get "sessions/new"
  get "users/new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"

  # ユーザ管理機能
  get "signup", to: "users#new"

  # ログイン機能
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "signup"  => "users#new"

  # localhost:3000/posts
  resources :posts, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]

  # localhost:3000/users
  resources :users, only: [ :new, :create, :show ]
end
