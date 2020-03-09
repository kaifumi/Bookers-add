Rails.application.routes.draw do
  get 'search/search',as:"search"
  root 'home#top'
  get 'home/about'
  devise_for :users
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

  
end
