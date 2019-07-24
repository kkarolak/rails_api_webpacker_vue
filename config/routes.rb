Rails.application.routes.draw do
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  resources :users
  get 'test', to: 'users#test'
  resources :articles do
    resources :comments
  end

  root to: 'articles#index'
end
