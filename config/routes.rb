Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :players
      resources :teams
      resources :leagues
      resources :users
      resources :drafts

      # route to login
			post "/login", to: "auth#login"

			# login on refresh
			get '/auto_login', to: "auth#auto_login"

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
