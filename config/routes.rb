Rails.application.routes.draw do

  root 'api/v1/frames#index'
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :frames
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
