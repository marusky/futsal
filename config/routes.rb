Rails.application.routes.draw do
  resources :players, except: :destroy
  resources :games, only: [:show, :create, :destroy] do
    member do
      get "matches", to: "games#matches"
      get "appearances", to: "games#appearances"
      patch "start", to: "games#start"
      patch "finish", to: "games#finish"
    end
  end
  resources :teams, except: [:index, :show]
  resources :matches, only: [:new, :create, :update]
  resources :appearances, only: :update
  
  get "statistics", to: "pages#statistics"
  get "charts", to: "pages#charts"

  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "pages#home"
end
