Rails.application.routes.draw do
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

  namespace :vendor do
    resource :dashboard, only: [ :show ]
    resources :users, only: [ :show ]
    resources :requests, only: [ :index, :show ] do
      resources :claims, only: [ :new, :create ], module: :requests
    end
  end

  namespace :customer do
    resources :users, only: [ :show ] do
      resources :requests, only: [ :index, :show, :new, :create ]
      resources :vehicles do
        resource :default, only: [ :create ], module: :vehicles
      end
    end
  end
end
