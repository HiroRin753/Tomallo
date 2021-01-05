Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: 'pages#index'
  resources :pages, only: [:index, :search, :prefecture]
  resources :houses do
    resources :reservations, only: [:index, :new, :create]
  end
  resources :users, only:[:show]

  get '/houses/prefecture/:id', to: "pages#prefecture"
  get 'pages/search'
  get '/auth/:provider/callback', to: 'sessions#create' #ログイン認証
  get '/logout', to: 'sessions#destroy' #ログアウト用
  get "/auth/failure", to: "sessions#failure" #認証失敗時用
end 