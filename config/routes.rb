Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users, :controllers => { sessions: 'users/sessions'}
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_scope :user do
    authenticated :user do
      root 'trips#index'
    end
    unauthenticated do
      root 'users/sessions#redirect_sign_in', as: :unauthenticated_root
    end
  end
  resources :plans, only: [:create, :update, :destroy, :show, :index, :new] 
  resources :trips, only: [:create, :update, :destroy, :show, :index, :new] do
    collection do 
      get :show_create
    end 
  end

  # Defines the root path route ("/")
  # root "posts#index"
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
end
