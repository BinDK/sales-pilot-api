Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'auth#login'
      
      resources :companies, only: [:create]
      resources :users, only: [:create]
      
      resources :llm_configs, only: [:create] do
        post :verify, on: :collection
      end
      
      get 'dashboard', to: 'dashboard#index'
      resources :conversations, only: [:index] do
        post :summarize, on: :member
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
