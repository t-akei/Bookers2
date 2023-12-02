class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"
# Userモデル(Userクラス)をclass_nameで指定してUserモデルからusersテーブルを
# 参照できるようにして擬似モデルfollower(フォローする=自分)モデルに
# Relationshipモデルが属しているように記述している
  
  belongs_to :followed, class_name: "User"
# 上記と同じくUserモデルから参照して
# 擬似モデルfollowed(自分にフォローされる)モデルに
# Relationshipモデルが属しているように記述
end
