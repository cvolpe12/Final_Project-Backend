Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :players
      resources :teams
      resources :leagues
      resources :users
      resources :drafts
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
