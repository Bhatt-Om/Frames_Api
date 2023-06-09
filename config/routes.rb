Rails.application.routes.draw do

  root 'pages#home'
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      resources :frames
      resources :posters
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
