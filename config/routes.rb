Rails.application.routes.draw do
  root to: 'pages#index'
  resources :pages, only: [:index, :search, :prefecture]
  resources :houses, only: [:new, :show, :crate, :edit, :update, :destroy, :map] do
    resources :reservations do
      member do
        get 'preload'
        get 'preview'
      end
    end
  end
  resources :users, only:[:show]

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  get '/houses/prefecture/:id', to: "pages#prefecture"
  get 'pages/search'
  get '/auth/:provider/callback', to: 'sessions#create' #ログイン認証
  get '/logout', to: 'sessions#destroy' #ログアウト用
  get "/auth/failure", to: "sessions#failure" #認証失敗時用
end 