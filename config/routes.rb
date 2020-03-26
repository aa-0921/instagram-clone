Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :insta_posts, only: [:create, :destroy, :show] do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
end
