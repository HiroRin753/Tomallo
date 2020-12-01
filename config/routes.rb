Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'houses#index'
  resources :houses 
  resources :users, only: :show

  get '/auth/:provider/callback', to: 'sessions#create' #ログイン認証
  get '/logout', to: 'sessions#destroy' #ログアウト用
  get "/auth/failure", to: "sessions#failure" #認証失敗時用
end