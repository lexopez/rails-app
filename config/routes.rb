Rails.application.routes.draw do
  root "posts#index"

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        confirmations: 'users/confirmations',
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
