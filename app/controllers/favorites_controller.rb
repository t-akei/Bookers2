class FavoritesController < ApplicationController
  # いいねをする機能
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    # current_user(今ログインしているユーザー)のfavoritesテーブル(レコード)
    # を.newで新規作成しようとしている。
    # 但し.newしているだけで、current_user.favorites.new(book_id: book.id)という
    # このデータ(=インスタンス)はまだデータベースに保存されていない。
    favorite.save
    # redirect_to request.referer
    # リダイレクト先を削除、かつJavaScriptリクエストのため
    # app/views/favorites/create.js.erbファイルを探す
  end

  # いいねを外す機能
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    # redirect_to request.referer
    # リダイレクト先を削除、かつJavaScriptリクエストのため
    # app/views/favorites/destroy.js.erbファイルを探す
  end
end
