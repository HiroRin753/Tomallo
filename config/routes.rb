Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'pages#index'
  resources :users, only:[:show]
  resources :pages, only: [:index, :search, :prefecture, :room_type]
  resources :houses, only: [:new, :show, :crate, :edit, :update, :destroy, :map] do
    resources :reservations do
      member do
        get 'preload'
        get 'preview'
      end
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  get '/houses/room_type/:id', to: 'pages#room_type'
  get '/houses/prefecture/:id', to: "pages#prefecture"
  get 'pages/search'
  get '/auth/:provider/callback', to: 'sessions#create' #ログイン認証
  get '/logout', to: 'sessions#destroy' #ログアウト用
  get "/auth/failure", to: "sessions#failure" #認証失敗時用
end 