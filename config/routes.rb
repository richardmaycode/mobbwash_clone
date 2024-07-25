Rails.application.routes.draw do
  get "registrations/new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  #
  #

  # Authentication
  resources :registrations, only: [ :new, :create ]
  resources :sessions, only: [ :new, :create ]
  get "logout", to: "session#destroy", as: :logout

  # Admin Views
  namespace :admin do
    resources :customers
    resources :vendors
    resources :vehicles
    resources :services
    resources :requests
  end

  # Customer Views
  namespace :customer do
    resources :users, only: [ :show ] do
      resources :requests, only: [ :index, :show, :new, :create ]
      resources :vehicles do
        resource :default, only: [ :create ], module: :vehicles
      end
    end
  end

  # Vendor Views
  namespace :vendor do
    resource :dashboard, only: [ :show ]
    resources :users, only: [ :show ]
    namespace :completions do
      resources :requests, only: [ :edit, :update ]
    end
    resources :requests, only: [ :index, :show ] do
      resources :claims, only: [ :new, :create ], module: :requests
      resources :cancellations, only: [ :new, :create ], module: :requests
    end
  end
end
