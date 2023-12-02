Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'follower' => 'relationships#follower', as: 'follower'
    # フォローをするユーザー＝自分
    get 'followed' => 'relationships#followed', as: 'followed'
    # 自分にフォローされるユーザー
  end
  get '/home/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
