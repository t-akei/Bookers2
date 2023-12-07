class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  # Bookモデルにfavorited_by?(user)メソッドを追加している
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
    # favoritesテーブルはBookモデルとFavoriteモデルをアソシエーションしたから
    # 使用できる。
    # exists?メソッドは「与えられた条件に合致するレコードが
    # 存在するかどうかをチェックする」メソッド
    # favorites.exists?(user_id: user.id) は、favoritesテーブルには、user_idカラムにuser.idを持ったレコードが
    # 存在しますか？ということ。
    # このメソッドを使うと(例)book.favorited_by?(user)とした場合
    # ある投稿(book)が引数の(user)によって「いいね」されているかorいないか、を判断できる
    # ユーザがいいねしている場合はtrueを、していない場合はfalseを返す。
  
  
  def self.search_for(content, method)
    if method == '完全一致'
      Book.where(title: content)
    elsif method == '前方一致'
      Book.where('title LIKE ?', content + '%')
    elsif method == '後方一致'
      Book.where('title LIKE ?', '%' + content)
    else method == '部分一致'
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
end
