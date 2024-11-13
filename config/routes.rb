Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, param: :id, only: [ :show ] do
        resources :follows, only: [ :index ] do
            post ":following_user_id", action: :create, on: :collection
            delete ":following_user_id", action: :destroy, on: :collection
        end
        resources :sleeps, param: :user_id, only: [ :index, :create ] do
          get "following", on: :member
        end
      end
      # resources :users, param: :user_id, only: [ :show ]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
