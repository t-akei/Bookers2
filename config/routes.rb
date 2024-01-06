Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # do~end のネスト（関連付け）は、異なるリソース間の親子関係を表現するための仕組み
  # 「いいね」は投稿に対してされるのでbooksコントローラとネストする。
  # いいねの削除を行う際には、いいねをしたユーザーIDとされた投稿IDがわかれば
  # どのいいねを削除するかを特定できる。favoriteのIDは無くても問題ない。
  # そのため、favoritesテーブルはidが含まれない子の関係であるresourceになる。

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
  devise_scope :user do
  #devise_scopeはroutes.rb内でDeviseのスコープを指定するためのメソッド
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

end
