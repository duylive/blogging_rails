Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :posts do
    resources :comments
  end

  namespace :admin do
    resources :users
  end

  resources :users, only: [:index, :edit, :update]

  get '/profile', to: 'profile#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
