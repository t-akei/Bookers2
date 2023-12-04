Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    
    get 'follower' => 'relationships#follower', as: 'follower'
    # フォロー一覧画面用のURL
    get 'followed' => 'relationships#followed', as: 'followed'
    # フォロワー一覧画面用のURL
    # 上記２つもUserモデルにネストする関係だからdo~end内に記述
  end
  get '/home/about' => 'homes#about', as: 'about'
  get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
