Rails.application.routes.draw do
  resources :reservationcs
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/edit'
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'pages#index'
  resources :pages, only: [:index, :search, :prefecture]
  resources :houses, only: [:index, :new, :create, :show]
  resources :users, only:[:show]

  get '/houses/prefecture/:id', to: "pages#prefecture"
  get 'pages/search'
  get '/auth/:provider/callback', to: 'sessions#create' #ログイン認証
  get '/logout', to: 'sessions#destroy' #ログアウト用
  get "/auth/failure", to: "sessions#failure" #認証失敗時用
end