Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords' }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_scope :user do
    authenticated :user do
      root 'home#index'
    end
    unauthenticated do
      root 'users/sessions#redirect_sign_in', as: :unauthenticated_root
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
