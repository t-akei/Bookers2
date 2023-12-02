class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  
  # フォローする自分、自分にフォローされたの関係を表す
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 擬似アソシエーションしたfollower/followedモデルをUserモデルが持っているように記述して
  # class_nameでUserモデルの本当のアソシエーション先であるRelationshipを指定して
  # foreign_keyはRelationshipモデルが外部キーとして何カラムを持つかを表している
  
  
  # フォロー一覧で使う
  
  # フォローする方
  has_many :follower_users, through: :relationships, source: :follower
  # 架空のfollower_usersモデルが中間テーブルrelationshipsを通して
  # 実際にフォローするユーザーのデータを取得しにいく擬似モデルfollowerモデル(=Relationshipモデル)をsourceで記述している
  
  # 自分にフォローされる方
  has_many :followed_users, through: :relationships, source: :followed
  # 架空のfollowed_usersモデルが中間テーブルrelationshipsを通して
  # 擬似モデルfollowedから自分がフォローするユーザーのデータをsourceで実際に取得している

  has_one_attached :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
