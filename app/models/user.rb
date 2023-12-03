class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  
  # フォローする、フォローされたの関係を表す
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 擬似アソシエーションしたfollower/followedモデルをUserモデルが持っているように記述して
  # class_nameでUserモデルの本当のアソシエーション先であるRelationshipを指定して
  # foreign_keyはRelationshipモデルが外部キーとして何カラムを持つかを表している
  # class_name以降の情報をfollowers/followedそれぞれに代入しているようなイメージ
  
  
  # フォロー/フォロワーの一覧で使う
  
  # フォローする側一覧
  has_many :follower_users, through: :followers, source: :followed
  # フォローする側が、誰をフォローしているのか情報が欲しい。だから10行目のfollowersを通して
  # フォローする側が持ってる、フォローする側がフォローした(=フォローされた)ユーザー情報をsourceで取得している
  # だからsource:は「フォローされた」であるfollowed
  
  # フォローされてる側(フォロワー)一覧
  has_many :followed_users, through: :followeds, source: :follower
  # フォローされている側が、誰にフォローされているのか情報が欲しい。だから11行目followedsを通して
  # フォローされている側が持っている、誰がフォローしているのかのユーザー情報をsourceで取得している
  # だからsource:は「フォローしている(言い換えると：フォローする)」であるfollower
  
  # フォローするときの処理
  # なせ引数がuser_id？Userモデルに記述、かつusersテーブルが持っているカラム
  # id,name,introductionだから引数はuser.idでは？
  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  
  # フォローを外す時の処理
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
    
  #フォローしていればtrueを返す、フォローしてない場合はfalseを返す
  # `following?`メソッドは、あるユーザーが別のユーザーをフォローしているかどうかを確認するためのメソッド
  def following?(user)
    follower_users.include?(user)
    # `following?`メソッドは、follower_users(フォローするユーザーの擬似モデル)
    # 内に、following?(user)で指定したuser情報が含まれているか
    # 判定するためにinclude?メソッドを使用している
  end
    
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
