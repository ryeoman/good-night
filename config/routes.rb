Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, param: :id, only: [ :show ] do
        get "following/sleeps", to: "sleeps#following"

        resources :sleeps, only: [ :index, :create ]

        resources :follows, only: [ :index ], controller: "follows" do
          delete ":following_id", to: "follows#destroy", on: :collection, as: :unfollow_action  # DELETE /users/:user_id/follows/:following_id
          post ":following_id", to: "follows#create", on: :collection, as: :follow_action # POST /users/:user_id/follows/:following_id
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
