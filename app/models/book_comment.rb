class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :parent, class_name: "BookComment", optional: true
  has_many   :replies, class_name: "BookComment", foreign_key: :parent_id, dependent: :destroy

  validates :comment, presence: true
end
