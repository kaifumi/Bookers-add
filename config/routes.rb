Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:show,:create,:destroy]
  end

  root 'home#top'
  get 'home/about'
end
