Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: {       # ← 恐らく最初は”devise_for:”のみの記載かと
    registrations: "users/registrations"
  }
  get 'search/search',as:"search"
  root 'home#top'
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update] do
    # memberメソッドを使うとユーザーIDを含んで指定のURLを生成する
    member do
      get :following, :followers
    end
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:show,:create,:destroy]
  end
  resources :relationships, only: [:create, :destroy]

  get "room/show"
  # チャット機能のルーティング
  resources :rooms do
    member do
      get :users
    end
  end
  # フロントとバックエンドをつなげるおまじない
  mount ActionCable.server => '/cable'
  
end
