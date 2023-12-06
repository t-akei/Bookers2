class Book < ApplicationRecord

  belongs_to :user
  
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
